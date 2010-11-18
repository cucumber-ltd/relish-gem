module Relish
  module ErrorMessages
    module_function
  
    def project_blank
      'Please specify a project.' + help
    end
    
    def handle_blank
      'Please specify a new handle.' + help
    end
    
    def version_blank
      'Please specify a version name.' + help
    end
  
    def unknown_command
      'Unknown command.' + help
    end
  
    def help(pad = true)
      (pad ? ' ' : '') + "Run 'relish help' for usage information."
    end
  end
end