require 'rubygems'
require 'json'

module Relish
  module Command
    class Projects < Base
      
      desc    'list your projects'
      command :default => :list
      
      usage   'projects:list'
      desc    'list your projects'
      command :list do
        response = resource['projects'].get(:accept => :json)
        puts format(response)
      end
      
      usage   'projects:add <org_or_user_handle>/<project_handle>'
      desc    'add a project'
      command :add do
        puts resource['projects'].post(:handle => @param)
      end
      
      usage   'projects:remove <org_or_user_handle>/<project_handle>'
      desc    'remove a project'
      command :remove do
        puts resource["projects/#{@param}"].delete
      end
      
    private
      def format(response)
        json = JSON.parse(response)
        json.map do |hash| 
          result = hash['project']['full_handle']
          result << " (private)" if hash['project']['private']
          result
        end.join("\n")
      end
            
    end
  end
end