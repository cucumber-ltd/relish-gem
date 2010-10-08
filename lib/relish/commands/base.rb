require 'trollop'
require 'relish/helpers'

module Relish
  module Command
    class Base
      include Relish::Helpers
      
      DEFAULT_HOST = 'relishapp.com'
      LOCAL_OPTIONS_FILE = '.relish'
      
      def initialize(global_options = {})
        @options = global_options
      end
      
      [:organization, :project].each do |meth|
        define_method meth do
          @options[meth] || parse_options_file[meth]
        end
      end
      
      def host
        @options[:host] || DEFAULT_HOST
      end
      
      def parse_options_file
        @parsed_options_file ||= begin
          if File.exist?(LOCAL_OPTIONS_FILE)
            parser = Trollop::Parser.new
            parser.opt :organization, "", :short => '-o', :type => String
            parser.opt :project,      "", :short => '-p', :type => String
            parser.opt :version,      "", :short => '-v', :type => String
            parser.parse(File.read(LOCAL_OPTIONS_FILE).split)
          else {} end
        end
      end
      
      def api_token
        File.read("#{home_directory}/.relish/api_token")
      end
      
    end
  end
end