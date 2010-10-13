require 'rubygems'
require 'zlib'
require 'archive/tar/minitar'
require 'stringio'
require 'rest_client'

module Relish
  module Command
    class Push < Base
      
      def default
        run
      end
      
      def run
        post files_as_tar_gz
      end
          
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
        "".tap do |str|
          str << "http://#{host}/pushes?"
          str << "creator_id=#{organization}&" if organization
          str << "project_id=#{project}&"
          str << "version_id=#{version}&" if version
          str << "api_token=#{api_token}"
        end
      end
      
      def version
        @options['--version'] || @options['-v']
      end
      
      def files_as_tar_gz
        stream = StringIO.new
        begin
          tgz = Zlib::GzipWriter.new(stream)
          tar = Archive::Tar::Minitar::Output.new(tgz)
          files.each do |entry|
            Archive::Tar::Minitar.pack_file(entry, tar)
          end
        ensure
          tar.close if tar # Closes both tar and tgz.
        end
        stream.string
      end
      
      def files
        Dir['features/**/*.{feature,md,markdown}']
      end
      
    end
  end
end