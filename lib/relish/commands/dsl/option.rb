module Relish
  module Command
    module Dsl
      class Option
        include ContextClass
        
        def define(name, options = {})
          name = name.to_s
          default_proc = options[:default] || Proc.new {}

          context_class_eval do
            define_method(name) do
              cli_options[name] ||
              local_options_file[name] ||
              global_options_file[name] ||
              instance_exec(&default_proc)
            end
          end
        end
        
        def self.names
          @@names ||= []
        end
        
      end
    end
  end
end