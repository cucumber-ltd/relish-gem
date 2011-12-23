require 'relish/command'
begin
  require 'rake/dsl_definition'
rescue LoadError
end

module Relish
  module Rake

    # Usage (in Rakefile):
    #
    #   require 'relish/rake/tasks'
    #   namespace :relish do
    #     Relish::Rake::PushTask.new(:push) do |t|
    #       t.project_name = 'gemname'
    #       t.version      = Gemname::VERSION
    #     end
    #   end
    #
    class PushTask
      include ::Rake::DSL if defined?(::Rake::DSL)

      attr_accessor :project_name, :version

      def initialize task_name=:relish_push
        raise 'you should specify a block with configuration' unless block_given?

        @task_name = task_name

        yield self

        define_task!
      end

      def define_task!
        desc "Push #{project_name}:#{version} documentation to relishapp"
        task @task_name do
          Relish::Command.run('push', ["#{project_name}:#{version}"])
        end
      end
    end
  end
end
