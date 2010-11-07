module Relish
  module Command
    module Dsl
      
      def option(name, options = {})
        default_proc = options[:default] || lambda {}
        define_method(name) do
          @cli_options[name.to_s] || parsed_options_file[name.to_s] || instance_exec(&default_proc)
        end
      end
      
    end
  end
end