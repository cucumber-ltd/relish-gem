require 'rubygems'
require 'trollop'
require 'relish/commands/push_command'

module Relish
  module Cli
    class OptionsParser < Trollop::Parser
      COMMANDS = { 'push' => Commands::PushCommand }
      
      def initialize(error_stream, out_stream)
        super
        
        banner  "This is the relish gem. Valid commands are: #{valid_commands.join(",")}"
        opt     :help, "Show help information"
        opt     :host, "Host to connect to",       :default => "relishapp.com"
        opt     :account, "Account to connect to", :type => String, :required => true
        opt     :project, "Project to connect to", :type => String, :required => true
        opt     :version, "Version to connect to", :type => String
        stop_on valid_commands
      end

      def command(args)
        Trollop.with_standard_exception_handling(self) do
          global_options = parse(args)
          grab_command(global_options)
        end
      end
      
    private
    
      def grab_command(global_options)
        command_name = leftovers.shift
        raise Trollop::HelpNeeded unless command_name
        unless valid_commands.include?(command_name)
          die("'#{command_name}' is not a relish command", nil)
        end
        command_class(command_name).new(global_options)
      end
      
      def valid_commands
        COMMANDS.keys
      end
      
      def command_class(command_name)
        COMMANDS[command_name] or raise(NotImplementedError)
      end
    end
  end
end