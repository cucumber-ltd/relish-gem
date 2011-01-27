module Relish
  module Command
    class Versions < Base
      include ResourceMethods
      resource_path :versions

      desc    'list the versions for a project'
      command :default do
        puts format(resource[resource_path_for_no_option].get(:accept => :json))
      end

      usage   'versions:add <project>:<version>'
      desc    'add a version to a project',
              'example: relish versions:add rspec/rspec-core:2.0'
      command :add do
        puts resource[resource_path_for_option].post(
          :version => { :name => version_name }
        )
      end

      usage   'versions:remove <project>:<version>'
      desc    'remove a version from a project',
              'example: relish versions:remove rspec/rspec-core:2.0'
      command :remove do
        puts resource["#{resource_path_for_option}/#{version_name}"].delete
      end

    private

      def version_name
        @param && @param.extract_option || error(:version_blank)
      end

      def format(response)
        json_parse(response) do |hash|
          "#{hash['version']['name']}"
        end
      end

    end
  end
end