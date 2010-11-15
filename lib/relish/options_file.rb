require 'relish/commands/base'
require 'yaml'

module Relish

  # Represents a .relish file
  class OptionsFile

    def initialize(path)
      @path = path
    end
    
    # Store the given options into the file. Existing options with the same keys
    # will be overwritten.
    def store(options)
      @options = self.options.merge(options)
      FileUtils.touch(@path)
      File.open(@path, 'w') do |file|
        YAML.dump(@options, file)
      end
    end
    
    def [](key)
      options[key]
    end
    
    def == (other)
      options == other
    end
    
    def merge(other)
      options.merge(other.options)
    end
    
    # Stored options as a hash
    def options
      @options ||= current_options
    end
    
  private
  
    def current_options
      return {} unless File.exist?(@path)
      YAML.load_file(@path)
    end

  end

end