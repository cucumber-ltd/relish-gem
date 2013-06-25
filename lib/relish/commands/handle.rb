module Relish
  module Commands
    class Handle
      def initialize(string)
        @project_id, @publisher_id = *string.split('/').reverse
      end

      def resource_url
        result = "projects/#{@project_id}"
        result << "?publisher_id=#{@publisher_id}" if @publisher_id
        result
      end
    end
  end
end
