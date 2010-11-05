require 'relish/commands/base'
require 'yaml'

module Relish
  class GlobalOptions
    def store(options)
      new_options = current_options.merge(options)
      File.open(path, 'w') do |file|
        file.puts new_options.to_yaml
      end
    end
    
  private
  
    def current_options
      YAML.load_file(path)
    end
    
    def path
      Relish::Commands::Base::GLOBAL_OPTIONS_FILE
    end
  end
end