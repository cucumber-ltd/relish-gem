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
      
      def option_names
        @@option_names ||= []
      end
      
      def option_names_to_display
        @@option_names_to_display ||= []
      end
      
    end
  end
end