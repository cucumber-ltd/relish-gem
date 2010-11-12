require 'relish'
require 'relish/helpers'
require 'relish/commands/base'
require 'relish/commands/push'
require 'relish/commands/config'
require 'relish/commands/projects'
require 'relish/commands/help'

module Relish
  module Command
    
    class << self
      include Relish::Helpers
      
      def run(command, args)
        command_class, method = get_command_and_method(command, args)      
        command_class.new(args).send(method)
      end
    
      def get_command_and_method(command, args)
        command_class, method = command.split(':')
        return get_command(command_class.capitalize), get_method(method)
      rescue NameError
        error "Unknown command. Run 'relish help' for usage information."
      end
      
    private
    
      def get_command(command)
        Relish::Command.const_get(command)
      end
      
      def get_method(method)
        method || :default
      end
      
    end
    
  end
end