require 'yaml'
require 'relish/ui'
require 'relish/options_file'
require 'relish/commands/dsl'

module Relish
  module Command
    class Base
      extend Dsl
      
      DEFAULT_HOST = 'relishapp.com'
      GLOBAL_OPTIONS_FILE = File.join(File.expand_path('~'), '.relish')
      LOCAL_OPTIONS_FILE = '.relish'
      
      attr_writer :args
            
      def initialize(args = [])
        @args = clean_args(args)
        @param = get_param
        @cli_options = Hash[*@args]
      end
      
      def url
        "http://#{host}/api"
      end
      
      def get_param
        @args.shift if @args.size.odd?
      end

    private
      
      option :organization
      option :project
      option :api_token, :default => lambda { get_and_store_api_token }
      option :host,      :default => lambda { DEFAULT_HOST }
      
      def get_and_store_api_token
        api_token = get_api_token
        global_options.store('api_token' => api_token)
        api_token
      end
      
      def get_api_token
        email, password = ui.get_credentials
        
        raw_response = resource(:user => email, :password => password)['token'].get
        String.new(raw_response.to_s)
      end
      
      def resource(options = {})
        RestClient::Resource.new(url, options)
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
      
      def global_options
        @global_options ||= OptionsFile.new(GLOBAL_OPTIONS_FILE)
      end
      
      def ui
        @ui ||= Ui.new
      end
      
    end
  end
end