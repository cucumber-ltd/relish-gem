module Relish
  module Command
    module Dsl
      class Base
        
        attr_reader :context
        
        def initialize(context)
          @context = context
        end
        
        def context_eval(&block)
          context.class_eval(&block)
        end
        
        def context_name
          context.name.split('::').last.downcase
        end
        
      end
    end
  end
end