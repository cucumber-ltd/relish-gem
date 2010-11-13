require 'yaml'

module Relish
  module Command
    class Help < Base
      
      desc 'show this usage'
      command :default do
        puts "=== Available Commands\n\n"
        Dsl::HelpText.commands.each do |command, list|
          list.each {|hash| Formatter.new(command, hash).format }
        end
      end
      
      class Formatter
        attr_reader :command, :usage, :description
        
        def initialize(command, hash)
          @command = command
          @usage, @description = *hash.to_a.flatten
        end
        
        def usage
          @usage == 'default' ? @command : @usage
        end
      
        def format        
          description.split("\n").each_with_index do |part, index|
            puts "#{format_usage(index)} # #{part}"
          end
        end
      
        def format_usage(index)
          if index.zero?
            usage.ljust(max_usage_length)
          else
            " " * max_usage_length
          end
        end
      
        def max_usage_length
          Dsl::HelpText.max_usage_length
        end
      end
        
    end
  end
end