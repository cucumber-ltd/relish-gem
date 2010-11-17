module Relish
  module Command
    class Collab < Base
      
      desc    'list the collaborators for a project'
      command :default do
        puts format(resource[resource_path_for_no_option].get(:accept => :json))
      end
      
      usage   'collab:add <project>:<collaborator handle or email>'
      desc    ['add a collaborator to a project',
               'example: relish collab:add rspec/rspec-core:justin']
      command :add do
        puts resource[resource_path_for_option].post(:handle_or_email => handle_or_email)
      end
      
      usage   'collab:remove <project>:<collaborator handle or email>'
      desc    ['remove a collaborator from a project',
               'example: relish collab:remove rspec/rspec-core:justin']
      command :remove do
        puts resource["#{resource_path_for_option}/#{handle_or_email}"].delete
      end
      
    private
      
      def resource_path_for_no_option
        resource_path(@param || project)
      end
      
      def resource_path_for_option
        resource_path(@param.extract_project_handle || project)
      end
      
      def resource_path(project)
        "projects/#{escape(project)}/memberships"
      end
      
      def handle_or_email
        @param.extract_option
      end
    
      def format(response)
        json_parse(response) do |hash|
          "#{hash['user']['handle']} (#{hash['user']['email']})"
        end
      end
      
    end
  end
end