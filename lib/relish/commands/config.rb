module Relish
  module Command
    class Config < Base

      class Option
        VALID_OPTIONS = %w(project)

        def initialize(param)
          @option, @value = param.split(':')
          validate_option
        end

        def validate_option
          unless VALID_OPTIONS.include?(@option)
            Relish::Helpers.error "'#{@option}' is not a valid option." +
                                  " Valid options: #{VALID_OPTIONS.join(', ')}"
          end
        end

        def to_hash
          {@option => @value}
        end
      end

      desc    'display the contents of your options file'
      command :default do
        puts(if File.exists?(Relish.local_options_file)
          IO.read(Relish.local_options_file)
        else
          "No #{Relish.local_options_file} file exists"
        end)
      end

      usage   'config:add <option>:<value>'
      desc    'add a configuration option to your options file',
              'example: relish config:add project:rspec-core',
              "valid configuration options: #{Option::VALID_OPTIONS.join(', ')}"
      command :add do
        option = Option.new(@param)
        OptionsFile.new(Relish.local_options_file).store(option.to_hash)
      end

    end
  end
end