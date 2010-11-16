module Relish
  module Command
    module ParamMethods
      
      def extract_option
        include?(':') ? split(':')[1] : self
      end

      def without_option
        split(':')[0]
      end

      def has_option?
        include?(':')
      end
      
      def extract_project_handle
        self && (has_option? ? true : nil) && without_option
      end
      
    end
  end
end   