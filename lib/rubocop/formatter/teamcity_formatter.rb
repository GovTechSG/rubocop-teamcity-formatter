# frozen_string_literal: true

# rubocop:disable Style/Documentation, Metrics/AbcSize

require 'rubocop'

module RuboCop
  module Formatter
    class TeamCityFormatter < RuboCop::Formatter::BaseFormatter
      COPS = Cop::Cop.all

      def started(_)
        output.puts(
          teamcity_escape(
            '##teamcity[testSuiteStarted name=\'Rubocop\']'
          )
        )
      end

      def file_finished(file, offences)
        COPS.each do |cop|
          offences.select { |off| off.cop_name == cop.cop_name }.each do |off|
            output.puts "##teamcity[testStarted name='#{file}']"
            output.puts "##teamcity[testFailed name='#{file}' message=" \
              "'#{off.location.to_s.gsub("#{Dir.pwd}/", '')}: #{off.message}']"
            output.puts "##teamcity[testFinished name='#{file}']"
          end
        end
      end

      def finished(_)
        output.puts(
          teamcity_escape(
            '##teamcity[testSuiteFinished name=\'Rubocop\']'
          )
        )
      end

      private

      def teamcity_escape(message)
        message.tr('\\', '|')
      end
    end
  end
end

# rubocop:enable Style/Documentation, Metrics/AbcSize
