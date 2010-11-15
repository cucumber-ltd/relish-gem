module Relish
  module Helpers
    
    def error(message)
      $stderr.puts(message)
      exit 1
    end
    module_function :error
    
  end
end