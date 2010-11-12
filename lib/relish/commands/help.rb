require 'yaml'

module Relish
  module Command
    class Help < Base
      
      desc    'show this usage'
      command :default do
        puts "=== Available Commands\n\n"

        Dsl::HelpText.commands.each do |command, list|
          list.each do |hash|
            usage, description = *hash.to_a.flatten
            usage = command if usage == 'default'
            puts "#{usage.ljust(max_command_length)} # #{description}"
          end
        end
      end
      
    private
      
      def max_command_length
        Dsl::HelpText.commands.values.map {|v|
          v.map {|v| v.keys.to_s.length }.max
        }.max
      end
    end
  end
end