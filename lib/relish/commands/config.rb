module Relish
  module Command
    class Config < Base
      
      def default
        show
      end
      
      def show
        puts(if File.exists?(LOCAL_OPTIONS_FILE)
          IO.read(LOCAL_OPTIONS_FILE)
        else
          "No #{LOCAL_OPTIONS_FILE} file exists"
        end)
      end
      
      def add
        File.open(LOCAL_OPTIONS_FILE, 'a') do |f|
          f.write(YAML::dump(Hash[*@args]))
        end
      end
      
    end
  end
end