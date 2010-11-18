module Relish
  module Command
    class Projects < Base
      
      desc    'list your projects'
      command :default do
        puts format(resource['projects'].get(:accept => :json))
      end
      
      usage   'projects:add <org or user handle>/<project handle>'
      desc    ['add a project',
               'append :private to make the project private',
               'example: relish projects:add rspec/rspec-core:private']
      command :add do
        puts resource['projects'].post(:handle => handle_to_add, :private => private?)
      end
      
      usage   'projects:remove <project>'
      desc    'remove a project'
      command :remove do
        puts resource["projects/#{escape(handle_to_remove)}"].delete
      end
      
      usage   'projects:visibility <project>:<public or private>'
      desc    ['set the status of a project',
               'example: relish projects:visibility rspec/rspec-core:private']
      command :visibility do
        puts resource["projects/#{escape(handle_to_update)}"].put(
          :project => { :private => private? }
        )
      end
      
      usage   'projects:rename <project>:<new handle>'
      desc    ["rename a project's handle",
               'example: relish projects:rename rspec/rspec-core:rspec-corez']
      command :rename do
        puts resource["projects/#{escape(handle_to_update)}"].put(
          :project => { :handle => rename_handle }
        )
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
        handle || error(:project_blank)
      end
      alias_method :handle_to_update, :handle_to_add
      
      def handle_to_remove
        handle || project
      end
      
      def handle
        @param.without_option if @param
      end
      
      def rename_handle
        @param.has_option? ? @param.extract_option : error(:handle_blank)
      end
      
      def private?
        @param.extract_option == 'private'
      end
            
    end
  end
end