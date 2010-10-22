module Relish
  module Command
    class Projects < Base
      
      def default
        list
      end
      
      def list
        a = resource['projects'].get
        puts a
      rescue RestClient::Exception => exception
        warn exception.response
        exit 1
      end
      
      def add
        resource.get
        puts "Project #{@param} added."
      rescue RestClient::Exception => exception
        warn exception.response
        exit 1
      end
      
      # 
      # def url
      #   "".tap do |str|
      #     str << "http://#{host}/api/pushes?"
      #     str << "creator_id=#{organization}&" if organization
      #     str << "project_id=#{project}&"
      #     str << "version_id=#{version}&" if version
      #     str << "api_token=#{api_token}"
      #   end
      # end
      
    end
  end
end