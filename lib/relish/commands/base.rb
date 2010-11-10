require 'yaml'
require 'relish/ui'
require 'relish/options_file'
require 'relish/commands/dsl'

module Relish
  module Command
    class Base
      extend Dsl
      
      option :project
      option :api_token, :default => lambda { get_and_store_api_token }
      option :host,      :default => lambda { Relish.default_host }, :display => false
      
      attr_writer :args
      attr_reader :cli_options
            
      def initialize(args = [])
        @args = clean_args(args)
        @param = get_param
        @cli_options = Hash[*@args]

        validate_cli_options
      end
      
      def url
        "http://#{host}/api"
      end
      
      def get_param
        @args.shift if @args.size.odd?
      end

    private

      def get_and_store_api_token
        api_token = get_api_token
        global_options_file.store('api_token' => api_token)
        api_token
      end
      
      def get_api_token
        email, password = ui.get_credentials
        
        raw_response = resource(:user => email, :password => password)['token'].get
        String.new(raw_response.to_s)
      end
      
      def resource(options = {})
        options[:user] ||= api_token
        options[:password] ||= 'X'
        RestClient::Resource.new(url, options)
      end
      
      def clean_args(args)
        args.inject([]) {|cleaned, arg| cleaned << arg.sub('--', '') }
      end
      
      def valid_option_names
        self.class.option_names
      end
      
      def option_names_to_display
        self.class.option_names_to_display
      end
      
      def validate_cli_options
        @cli_options.keys.each do |option|
          unless valid_option_names.include?(option.to_s)
            puts "#{option} is not a valid option.\n" +
                 "Valid options are: #{option_names_to_display.sort.join(', ')}"
                  
            exit 1
          end
        end
      end
      
      def global_options_file
        OptionsFile.new(Relish.global_options_file)
      end

      def local_options_file
        OptionsFile.new(Relish.local_options_file)
      end
      
      def ui
        @ui ||= Ui.new
      end
      
    end
  end
end