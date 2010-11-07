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
        File.open(Relish.local_options_file, 'a') do |f|
          f.write(YAML::dump(Hash[*@args]))
        end
      end
      
    end
  end
end