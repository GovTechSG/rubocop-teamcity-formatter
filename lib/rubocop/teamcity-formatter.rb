# rubocop:disable Style/FileName
module RuboCop
  module Formatter
    #
    class TeamCityFormatter < BaseFormatter
      COPS = Cop::Cop.all

      def teamcity_escape(message)
        message.tr('\\', '|')
      end

      def started(_)
        output.puts(
          teamcity_escape(
            '##teamcity[testSuiteStarted name=\'Rubocop\']'
          )
        )
      end

      # rubocop:disable Metrics/AbcSize
      def file_finished(file, offences)
        COPS.each do |cop|
          offences.select { |off| off.cop_name == cop.cop_name }.each do |off|
            output.puts "##teamcity[testStarted name='#{file}']"
            output.puts "##teamcity[testFailed name='#{file}' message=" \
              "'#{off.location.to_s.tr("#{Dir.pwd}/", '')}: #{off.message}']"
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
    end
  end
end
