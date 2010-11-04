require 'yaml'

module Relish
  module Command
    class Base
      DEFAULT_HOST = 'relishapp.com'
      GLOBAL_OPTIONS_FILE = File.join(File.expand_path('~'), '.relish')
      LOCAL_OPTIONS_FILE = '.relish'
      
      attr_writer :args
      
      def initialize(args = [])
        @args = clean_args(args)
        @param = get_param
        @options = get_options
      end
      
      def organization
        @options['organization']
      end
      
      def project
        @options['project']
      end
      
      def api_token
        @options['api_token']
      end
      
      def url
        "http://#{@options['host'] || DEFAULT_HOST}/api"
      end
      
      def resource
        RestClient::Resource.new(url)
      end

      def get_param
        @args.shift if @args.size.odd?
      end
      
      def get_options
        parsed_options_file.merge(Hash[*@args])
      end
      
      def parsed_options_file
        @parsed_options_file ||= {}.tap do |parsed_options|
          [GLOBAL_OPTIONS_FILE, LOCAL_OPTIONS_FILE].each do |options_file|
            parsed_options.merge!(YAML.load_file(options_file)) if File.exist?(options_file)
          end
        end
      end
      
      def clean_args(args)
        cleaned = []
        args.each do |arg|
          cleaned << arg.sub('--', '')
        end
        cleaned
      end
      
    end
  end
end