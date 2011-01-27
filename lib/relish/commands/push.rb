require 'zlib'
require 'archive/tar/minitar'
require 'stringio'
require 'rest_client'

module Relish
  module Command
    class Push < Base

      usage   'push <project>:<version>'
      desc    'push features to a project',
              '<version> is optional',
              'example: relish push rspec/rspec-core',
              'example: relish push rspec/rspec-core:2.0'
      command :default do
        post files_as_tar_gz, project_params
      end

      usage   'push:org <organization handle>'
      desc    'push markdown files to an organization',
              'example: relish push:org rspec'
      command :org do
        post files_as_tar_gz, organization_params
      end

    private

      def post(tar_gz_data, params)
        resource["pushes?#{params}"].post(tar_gz_data,
          :content_type => 'application/x-gzip')
        puts "sent:\n#{files.join("\n")}"
      end

      def project_params
        "".tap do |str|
          str << "project_id=#{project}"
          str << "&version_id=#{version}" if version
        end
      end

      def organization_params
        "organization_id=#{@param}"
      end

      def project
        (@param.without_option if @param) || super()
      end

      def version
        @param.extract_option if @param.has_option?
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
        Dir["features/**/*.{feature,md,markdown}"] +
        Dir["features/**/.nav"]
      end

    end


  end
end

