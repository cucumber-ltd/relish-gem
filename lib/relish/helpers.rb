module Relish
  module Helpers
    
    def error(message)
      $stderr.puts(message)
      exit 1
    end
    
  end
end