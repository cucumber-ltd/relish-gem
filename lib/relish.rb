module Relish
  class << self
    
    attr_writer :global_options_file
    def global_options_file
      @global_options_file ||= File.join(File.expand_path('~'), '.relish')
    end
  
    attr_writer :local_options_file
    def local_options_file
      @local_options_file ||= '.relish'
    end
  
    attr_writer :default_host
    def default_host
      @default_host ||= 'relishapp.com'
    end
  end
end