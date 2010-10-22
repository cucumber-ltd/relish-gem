require 'yaml'

module Relish
  module Command
    class Help < Base
      class << self
        def for_command(command, help)
          command_help[command] = help
        end
        
        def command_help
          @command_help ||= {}
        end
      end
      
      def default
        puts "This is the prefunctory help message for the relish gem."

        puts "Commands:"
        Help.command_help.each do |command, help|
          message = "relish #{command}".ljust(max_command_length) + 
                    " # " + help
          puts message
        end
      end
      
      def max_command_length
        Help.command_help.keys.map { |c| c.to_s.length }.max
      end
    end
  end
end