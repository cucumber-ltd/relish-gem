module Relish
  module Command
    module Dsl
      class HelpText
        
        class << self
          attr_accessor :current_command, :next_usage, :next_description
        
          def add(name, command)
            self.current_command = name
            commands[command] = [] unless commands.key?(command)
            commands[command].push(get_next_usage => get_next_description)
            reset_accessors
          end
        
          def get_next_usage
            next_usage or current_command.to_s
          end
        
          def get_next_description
            next_description || raise(
              "please set a description for #{current_command.inspect}"
            )
          end
        
          def commands
            @commands ||= {}
          end
        
          def reset_accessors
            self.current_command = self.next_usage = self.next_description = nil
          end
          
          def clear_commands
            @commands = {}
          end
          
          def max_usage_length
            commands.values.map {|v|
              v.map {|v| v.keys.to_s.length }.max
            }.max
          end
        end
        
      end
    end
  end
end