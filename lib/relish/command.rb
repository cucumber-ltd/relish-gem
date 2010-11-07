require 'relish'
require 'relish/commands/base'
require 'relish/commands/push'
require 'relish/commands/config'
require 'relish/commands/projects'
require 'relish/commands/help'

module Relish
  module Command
    
    def self.run(command, args)
      command_class, method = get_command_and_method(command, args)      
      command_class.new(args).send(method)
    end
    
    def self.get_command_and_method(command, args)
      command_class, method = command.split(':')
      return Relish::Command.const_get(command_class.capitalize), (method || :default)
    end
    
  end
end