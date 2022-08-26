# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'spec_helper'
require 'rubocop/formatter/teamcity_formatter'

RSpec.describe RuboCop::Formatter::TeamCityFormatter do
  subject { RuboCop::Formatter::TeamCityFormatter.new(Kernel) }

  describe '#started' do
    it 'outputs testSuiteStarted message' do
      expect do
        subject.started('something')
      end.to output(
        "##teamcity[testSuiteStarted name='Rubocop']\n"
      ).to_stdout
    end
  end

  describe '#finished' do
    it 'outputs testSuiteFinished message' do
      expect do
        subject.finished('something')
      end.to output(
        "##teamcity[testSuiteFinished name='Rubocop']\n"
      ).to_stdout
    end
  end

  describe '#file_finished' do
    before do
      @file = 'somefile.txt'
      Struct.new('TestStruct', :cop_name, :message, :location)
      @offence_list = [
        Struct::TestStruct.new('Lint/AmbiguousOperator',
                               'cop1 error1',
                               "#{Dir.pwd}/foo.rb:1:1"),
        Struct::TestStruct.new('Layout/BlockAlignment',
                               'cop2 error1',
                               "#{Dir.pwd}/foo.rb:2:1"),
        Struct::TestStruct.new('Lint/AmbiguousOperator',
                               'cop1 error2',
                               "#{Dir.pwd}/foo.rb:1:2"),
        Struct::TestStruct.new('Lint/AmbiguousOperator',
                               'don\'t do this [123,45]',
                               "#{Dir.pwd}/foo.rb:2:3")
      ]
    end

    it 'outputs offences in order' do
      expected_output = '' \
        "##teamcity[testStarted name='somefile.txt']\n" \
        "##teamcity[testFailed name='somefile.txt' " \
        "message='foo.rb:2:1: cop2 error1']\n" \
        "##teamcity[testFinished name='somefile.txt']\n" \
        "##teamcity[testStarted name='somefile.txt']\n" \
        "##teamcity[testFailed name='somefile.txt' " \
        "message='foo.rb:1:1: cop1 error1']\n" \
        "##teamcity[testFinished name='somefile.txt']\n" \
        "##teamcity[testStarted name='somefile.txt']\n" \
        "##teamcity[testFailed name='somefile.txt' " \
        "message='foo.rb:1:2: cop1 error2']\n" \
        "##teamcity[testFinished name='somefile.txt']\n" \
        "##teamcity[testStarted name='somefile.txt']\n" \
        "##teamcity[testFailed name='somefile.txt' " \
        "message='foo.rb:2:3: don|'t do this |[123,45|]']\n" \
        "##teamcity[testFinished name='somefile.txt']\n"

      expect do
        subject.file_finished(@file, @offence_list)
      end.to output(expected_output).to_stdout
    end
  end
end

# rubocop:enable Metrics/BlockLength
