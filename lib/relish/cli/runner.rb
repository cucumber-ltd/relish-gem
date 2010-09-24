require 'relish/cli/options'

module Relish
  module Cli
    class Runner
      def self.run(args, error_stream, out_stream)
        parser = OptionsParser.new(error_stream, out_stream)
        parser.command(args).run
      end
    end
  end
end