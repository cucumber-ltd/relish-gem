require 'rubygems'
require 'zlib'
require 'archive/tar/minitar'
require 'stringio'
require 'rest_client'
require 'relish/commands/help'

module Relish
  module Command    
    class Push < Base
      option :version
      
      desc    'push your features to relishapp.com'
      command :default do
        post files_as_tar_gz
      end
      
    private
          
      def post(tar_gz_data)
        resource["pushes?#{parameters}"].post(tar_gz_data,
          :content_type => 'application/x-gzip')
        puts "sent:\n#{files.join("\n")}"
      end
      
      def parameters
        "".tap do |str|
          str << "project_id=#{project}"
          str << "&version_id=#{version}" if version
        end
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

