require 'relish/commands/dsl/context_class'
require 'relish/commands/dsl/option'
require 'relish/commands/dsl/command'
require 'relish/commands/dsl/help_text'

module Relish
  module Command
    module Dsl
      
      def option(name, options = {})
        Option.new(self).define(name, options)
        Option.names << name.to_s
      end
      
      def usage(text)
        HelpText.next_usage = text
      end
      
      def desc(text)
        text = text.join("\n") if text.is_a?(Array)
        HelpText.next_description = text
      end
      
      def command(arg, &block)
        case arg
        when Hash
          name, alias_target = arg.to_a.flatten
          block = lambda { self.send(alias_target) }
        when Symbol
          name = arg
        else
          raise ArgumentError
        end
        
        Command.new(self).define(name, &block)
      end
      
    end
  end
end