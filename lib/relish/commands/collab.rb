module Relish
  module Command
    class Collab < Base
      
      desc    'list the collaborators for a project'
      command :default do
        puts format(resource[resource_path].get(:accept => :json))
      end
      
      usage   'collab:add <org_or_user_handle>/<project_handle>:' +
              '<collaborator_handle_or_email>'
      desc    ['add a collaborator to a project',
               'example: relish collab:add rspec/rspec-core:justin'].join("\n")
      command :add do
        puts resource[resource_path].post(:handle_or_email => handle_or_email)
      end
      
      usage   'collab:remove <org_or_user_handle>/<project_handle>:' +
              '<collaborator_handle_or_email>'
      desc    ['remove a collaborator from a project',
               'example: relish collab:remove rspec/rspec-core:justin'].join("\n")
      command :remove do
        puts resource["#{resource_path}/#{handle_or_email}"].delete
      end
      
    private
    
      def resource_path
        "projects/#{@param.remove_option}/memberships"
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