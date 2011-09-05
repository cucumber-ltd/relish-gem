require 'relish/version'

module Relish
  class << self

    def self.setting(name, value)
      attr_writer name
      class_eval %{
        def #{name}                              # def global_options_file
          @#{name.to_s} ||=                      #   @global_options_file ||= 
            ENV['RELISH_#{name.to_s.upcase}'] || #   ENV['RELISH_GLOBAL_OPTIONS_FILE'] || 
            '#{value}'                           #   '~/.relish'
        end                                      # end
      }
    end

    setting :global_options_file, File.join(File.expand_path('~'), '.relish')
    setting :local_options_file,  '.relish'
    setting :default_host,        'api.relishapp.com'
    setting :default_ssl,         'on'
  end
end
