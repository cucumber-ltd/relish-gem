require 'relish/commands/base'
require 'yaml'

module Relish
  class GlobalOptions
    def store(options)
      new_options = current_options.merge(options)
      File.open(path, 'w') do |file|
        YAML.dump(new_options, file)
      end
    end
    
  private
  
    def current_options
      return {} unless File.exist?(path)
      YAML.load_file(path)
    end
    
    def path
      Relish::Command::Base::GLOBAL_OPTIONS_FILE
    end
  end
end