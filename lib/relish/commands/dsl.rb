module Relish
  module Command
    module Dsl
      
      def option(name, options = {})
        name = name.to_s
        default_proc = options[:default] || Proc.new {}
        
        define_method(name) do
          cli_options[name] ||
          local_options_file[name] ||
          global_options_file[name] ||
          instance_exec(&default_proc)
        end
        
        option_names << name
        option_names_to_display << name unless options[:display] == false
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
        
        define_method(name) do
          begin
            instance_exec(&block)
          rescue RestClient::Exception => exception
            warn exception.response
            exit 1
          end
        end
      end
      
      def option_names
        @@option_names ||= []
      end
      
      def option_names_to_display
        @@option_names_to_display ||= []
      end
      
    end
  end
end