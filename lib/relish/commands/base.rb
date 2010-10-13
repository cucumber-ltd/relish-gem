require 'relish/helpers'

module Relish
  module Command
    class Base
      include Relish::Helpers
      
      DEFAULT_HOST = 'relishapp.com'
      LOCAL_OPTIONS_FILE = '.relish'
      
      attr_reader :args
      
      def initialize(args)
        @args = args
        @options = get_options
      end
      
      def organization
        @options['--organization'] || @options['-o']
      end
      
      def project
        @options['--project'] || @options['-p']
      end
      
      def host
        @options['--host'] || DEFAULT_HOST
      end
      
      def parse_options_file
        if File.exist?(LOCAL_OPTIONS_FILE)
          Hash[*File.read(LOCAL_OPTIONS_FILE).split]
        else {} end
      end
      
      def get_options
        parse_options_file.merge(Hash[*args])
      end
      
      def api_token
        File.read("#{home_directory}/.relish/api_token")
      end
      
    end
  end
end