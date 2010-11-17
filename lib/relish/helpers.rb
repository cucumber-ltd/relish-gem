module Relish
  module Helpers
    
    def error(message)
      message = ErrorMessages.send(message) if message.is_a?(Symbol)
      
      $stderr.puts(message)
      exit 1
    end
    module_function :error
    
  end
end