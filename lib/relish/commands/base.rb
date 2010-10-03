module Relish
  module Command
    class Base
      include Relish::Helpers
      
      def api_token
        File.read("#{home_directory}/.relish/api_token")
      end
      
    end
  end
end