require 'zlib'
require 'minitar'
require 'stringio'
require 'rest_client'

module Relish
  module Command
    class Push < Base

      usage   'push <project>:<version> [path <path>]'
      option  :path, :default => Proc.new { 'features' }
      desc    'push features to a project',
              '<version> is optional',
              '<path> is optional (defaults to ./features)',
              'example: relish push rspec/rspec-core',
              'example: relish push rspec/rspec-core:2.0'
      command :default do
        post files_as_tar_gz, project_params
      end

      usage   'push:publisher <publisher name>'
      desc    'push markdown files to a publisher',
              'example: relish push:publisher rspec'
      command :publisher do
        post files_as_tar_gz, publisher_params
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

      def publisher_params
        "publisher_id=#{@param}"
      end

      def project
        (@param.without_option if @param) || super()
      end

      def version
        return unless @param
        @param.extract_option if @param.has_option?
      end

      def files_as_tar_gz
        stream = StringIO.new
        begin
          tgz = Zlib::GzipWriter.new(stream)
          tar = Minitar::Output.new(tgz)
          files.each do |entry|
            Minitar.pack_file(entry, tar)
          end
        ensure
          tar.close if tar # Closes both tar and tgz.
        end
        stream.string
      end

      def files
        Dir["#{path}/**/*.{feature,md,markdown}"] +
        Dir["#{path}/**/.nav"]
      end

    end


  end
end

