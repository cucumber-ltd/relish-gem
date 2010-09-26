require 'zlib'
require 'archive/tar/minitar'
require 'stringio'
require 'rest_client'

module Relish
  module Commands
    class PushCommand
      def initialize(global_options)
        @options = global_options
      end
      
      def run
        puts "pushing to #{url}"
        post(features_as_tar_gz)
        puts "sent:\n#{files.join("\n")}"
      end
      
    private
    
      def post(tar_gz_data)
        resource = RestClient::Resource.new(url)
        resource.post(tar_gz_data, :content_type => 'application/x-gzip')
      end
      
      def url
        host = @options[:host]
        account = @options[:account]
        project = @options[:project]
        "http://#{host}/pushes?account_id=#{account}&project_id=#{project}"
      end
      
      def options
        {}
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