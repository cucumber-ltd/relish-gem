module Relish
  module Command
    class Projects < Base

      desc    'list your projects'
      command :default do
        puts format(resource['projects'].get(:accept => :json))
      end
      
      usage   'projects:add <org_or_user_handle>/<project_handle>'
      desc    ['add a project',
               'append :private to make the project private',
               'example: relish projects:add rspec/rspec-core:private']
      command :add do
        puts resource['projects'].post(:handle => handle_to_add, :private => private?)
      end
      
      usage   'projects:remove <project_handle>'
      desc    'remove a project'
      command :remove do
        puts resource["projects/#{handle_to_remove}"].delete
      end
      
    private
    
      def format(response)
        json_parse(response) do |hash| 
          result = hash['project']['full_handle']
          result << " (private)" if hash['project']['private']
          result
        end
      end
      
      def handle_to_add
        handle || error(ErrorMessages.project_blank)
      end
      
      def handle_to_remove
        handle || project
      end
      
      def handle
        @param.without_option if @param
      end
      
      def private?
        @param.extract_option == 'private'
      end
            
    end
  end
end