require 'rubygems'
require 'json'

module Relish
  module Command
    class Projects < Base
      
      command :default => :list
      
      command :list do
        response = resource['projects'].get(
          :params => {:api_token => api_token}, 
          :accept => :json
        )
        puts format(response)
      end
      
      command :add do
        puts resource['projects'].post(:handle => @param)
      end
      
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