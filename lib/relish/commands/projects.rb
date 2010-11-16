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
        puts resource['projects'].post(:handle => handle, :private => private?)
      end
      
      usage   'projects:remove <project_handle>'
      desc    'remove a project'
      command :remove do
        puts resource["projects/#{handle}"].delete
      end
      
    private
    
      def format(response)
        json_parse(response) do |hash| 
          result = hash['project']['full_handle']
          result << " (private)" if hash['project']['private']
          result
        end
      end
      
      def handle
        @param ? @param.without_option : error('Please specify a project.')
      end
      
      def private?
        @param.extract_option == 'private'
      end
            
    end
  end
end