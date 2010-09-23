module Relish
  module Cli
    class Runner
      def self.run(args, error_stream, out_stream)
        out_stream.puts "yo yo"
      end
    end
  end
end