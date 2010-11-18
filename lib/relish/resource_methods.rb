module Relish
  module ResourceMethods
    def self.included(command_class)
      command_class.extend ClassMethods
    end
    
    module ClassMethods
      def resource_path(path)
        define_method :resource_path do |project|
          "projects/#{escape(project)}/#{path}"
        end
      end
    end
    
    def resource_path_for_no_option
      resource_path(@param || project)
    end
    
    def resource_path_for_option
      resource_path(@param.extract_project_handle || project)
    end
  end
end