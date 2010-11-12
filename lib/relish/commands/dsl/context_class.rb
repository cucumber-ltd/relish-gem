module Relish
  module Command
    module Dsl
      module ContextClass
        
        attr_reader :context_class
        
        def initialize(context_class)
          @context_class = context_class
        end
        
        def context_class_eval(&block)
          context_class.class_eval(&block)
        end
        
        def context_class_name
          context_class.name.split('::').last.downcase
        end
        
      end
    end
  end
end