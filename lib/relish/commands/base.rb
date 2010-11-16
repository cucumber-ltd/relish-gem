require 'yaml'
require 'json'
require 'relish/error_messages'
require 'relish/helpers'
require 'relish/options_file'
require 'relish/param_methods'
require 'relish/ui'
require 'relish/commands/dsl'

module Relish
  module Command
    class Base
      include Relish::Helpers
      extend Dsl
      
      option :api_token, :default => lambda { get_and_store_api_token }
      option :host,      :default => lambda { Relish.default_host }, :display => false
      
      attr_writer :args
      attr_reader :cli_options
            
      def initialize(args = [])
        @args = clean_args(args)
        @param = get_param.extend(ParamMethods)
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
    
      def project
        merged_options['project'] || error(ErrorMessages.project_blank)
      end

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
        Dsl::Option.names
      end
      
      def validate_cli_options
        cli_options.keys.each do |option|
          unless valid_option_names.include?(option.to_s)
            error "'#{option}' is not a valid option."
          end
        end
      end
      
      def merged_options
        @merged_options ||= global_options_file.merge(local_options_file)
      end
      
      def global_options_file
        @global_options ||= OptionsFile.new(Relish.global_options_file)
      end

      def local_options_file
        @local_options ||= OptionsFile.new(Relish.local_options_file)
      end
      
      def ui
        @ui ||= Ui.new
      end
      
      def json_parse(response, &block)
        JSON.parse(response).inject([]) do |parsed_output, hash|
          parsed_output << block.call(hash)
        end.join("\n")
      rescue JSON::ParserError
        response
      end
      
    end
  end
end