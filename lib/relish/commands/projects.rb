require 'rubygems'
require 'json'

module Relish
  module Command
    class Projects < Base
      
      def default
        list
      end
      
      def list
        response = resource['projects'].get(
          :params => {:api_token => api_token}, :accept => :json
        )
        puts format(response)
      rescue RestClient::Exception => exception
        warn exception.response
        exit 1
      end
      
      def format(response)
        json = JSON.parse(response)
        json.map do |hash| 
          result = hash['project']['handle']
          result << " (private)" if hash['project']['private']
          result
        end.join("\n")
      end
            
    end
  end
end