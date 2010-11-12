module Relish
  module Command
    module Dsl
      class Command < Base
        
        def define(name, &block)
          context_eval do
            define_method(name) do
              begin
                instance_exec(&block)
              rescue RestClient::Exception => exception
                warn exception.response
                exit 1
              end
            end
          end
          HelpText.add(name, context_name)
        end
        
      end
    end
  end
end