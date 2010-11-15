module Relish
  module Command
    class Help < Base
      
      desc 'show this usage'
      command :default do
        puts <<-TEXT
A <project> can be scoped by an organization or user handle. For
example, if an organiztion (rspec) has a project (rspec-core), then
the <project> would be `rspec/rspec-core`. If a user (justin) has a
project (my-project), then <project> would be `justin/my-project`.

If you leave off the organization or user handle, then it defaults
to the user (you).

        TEXT
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