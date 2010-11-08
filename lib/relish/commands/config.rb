module Relish
  module Command
    class Config < Base
      
      def default
        show
      end
      
      def show
        puts(if File.exists?(Relish.local_options_file)
          IO.read(Relish.local_options_file)
        else
          "No #{Relish.local_options_file} file exists"
        end)
      end
      
      def add
        OptionsFile.new(Relish.local_options_file).store(@cli_options)
      end
      
    end
  end
end