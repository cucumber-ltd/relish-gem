require 'yaml'
require 'relish/ui'
require 'relish/global_options'

module Relish
  module Command
    class Base
      DEFAULT_HOST = 'relishapp.com'
      GLOBAL_OPTIONS_FILE = File.join(File.expand_path('~'), '.relish')
      LOCAL_OPTIONS_FILE = '.relish'
      
      attr_writer :args
      
      def self.option(name, options = {})
        default_proc = options[:default] || lambda {}
        define_method(name) do
          @options[name.to_s] || parsed_options_file[name.to_s] || instance_exec(&default_proc)
        end
      end
      
      def initialize(args = [])
        @args = clean_args(args)
        @param = get_param
        @options = get_options
        @ui = Ui.new
      end
      
      option :organization
      option :project
      option :api_token, :default => lambda { get_and_store_api_token }
      
      def get_and_store_api_token
        api_token = get_api_token
        global_options.store(:api_token => api_token)
        api_token
      end
      
      def get_api_token
        email, password = ui.get_credentials
        resource(:user => email, :password => password)['token'].get
      end
      
      def url
        "http://#{@options['host'] || DEFAULT_HOST}/api"
      end
      
      def resource(options = {})
        RestClient::Resource.new(url, options)
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
      
    private
    
      def global_options
        @global_options ||= GlobalOptions.new
      end
      
      def ui
        @ui ||= Ui.new
      end
      
    end
  end
end