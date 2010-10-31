require 'rubygems'
require 'zlib'
require 'archive/tar/minitar'
require 'stringio'
require 'rest_client'
require 'relish/commands/help'

module Relish
  module Command
    Help.for_command(:push, "push your features to relishapp.com")
    
    class Push < Base
      
      def default
        run
      end
      
      def run
        post files_as_tar_gz
      end
          
      def post(tar_gz_data)
        resource["pushes?#{parameters}"].post(tar_gz_data,
          :content_type => 'application/x-gzip')
        puts "sent:\n#{files.join("\n")}"
      rescue RestClient::Exception => exception
        warn exception.response
        exit 1
      end
      
      def parameters
        "".tap do |str|
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

