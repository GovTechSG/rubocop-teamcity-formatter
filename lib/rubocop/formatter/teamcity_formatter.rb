# frozen_string_literal: true

# rubocop:disable Style/Documentation, Metrics/AbcSize

require 'rubocop'

module RuboCop
  module Formatter
    class TeamCityFormatter < RuboCop::Formatter::BaseFormatter
      COPS = Cop::Cop.all

      def started(_)
        output.puts(
          '##teamcity[testSuiteStarted name=\'Rubocop\']'
        )
      end

      def file_finished(file, offences)
        COPS.each do |cop|
          offences.select { |off| off.cop_name == cop.cop_name }.each do |off|
            output.puts "##teamcity[testStarted name='#{file}']"
            output.puts "##teamcity[testFailed name='#{file}' message=" \
              "'#{off.location.to_s.gsub("#{Dir.pwd}/", '')}: #{teamcity_escape(off.message)}']"
            output.puts "##teamcity[testFinished name='#{file}']"
          end
        end
      end

      def finished(_)
        output.puts(
          '##teamcity[testSuiteFinished name=\'Rubocop\']'
        )
      end

      private

      def teamcity_escape(message)
        # https://www.jetbrains.com/help/teamcity/service-messages.html#Escaped+Values
        message.gsub('|', '||')
               .gsub(/['\[\]]/, '|\0')
               .gsub('\n', '|n')
               .gsub('\r', '|r')
      end
    end
  end
end

# rubocop:enable Style/Documentation, Metrics/AbcSize
