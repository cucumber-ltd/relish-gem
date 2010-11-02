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
        raise args.inspect
      end
      
    end
  end
end