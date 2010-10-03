require 'zlib'
require 'archive/tar/minitar'
require 'stringio'
require 'rest_client'

module Relish
  module Command
    class Push < Base
      
      def initialize(global_options)
        @options = global_options
      end
      
      def run
        post features_as_tar_gz
      end
      
    private
    
      def post(tar_gz_data)
        resource = RestClient::Resource.new(url)
        resource.post(tar_gz_data, :content_type => 'application/x-gzip')
        puts "sent:\n#{files.join("\n")}"
      rescue RestClient::ResourceNotFound,
             RestClient::Unauthorized,
             RestClient::BadRequest => exception
             
        warn exception.response
        exit 1
      end
      
      def url
        host = @options[:host]
        account = @options[:account]
        project = @options[:project]
        version = @options[:version]
        
        "http://#{host}/pushes?account_id=#{account}&project_id=#{project}&api_token=#{api_token}".tap do |str|
          str << "&version_id=#{version}" if version
        end
      end
      
      def features_as_tar_gz
        stream = StringIO.new
        
        begin
          tgz = Zlib::GzipWriter.new(stream)
          tar = Archive::Tar::Minitar::Output.new(tgz)
          files.each do |entry|
            Archive::Tar::Minitar.pack_file(entry, tar)
          end
        ensure
          # Closes both tar and sgz.
          tar.close if tar
        end
        
        stream.string
      end
      
      def files
        Dir['features/**/*.{feature,md}']
      end
      
    end
  end
end