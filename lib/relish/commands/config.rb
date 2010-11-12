module Relish
  module Command
    class Config < Base
      
      desc    'display the contents of your options file'
      command :default => :show
      
      usage   'config:show'
      desc    'display the contents of your options file'
      command :show do
        puts(if File.exists?(Relish.local_options_file)
          IO.read(Relish.local_options_file)
        else
          "No #{Relish.local_options_file} file exists"
        end)
      end
      
      usage   'config:add --<option> <value>'
      desc    'add a configuration option to your options file'
      command :add do
        OptionsFile.new(Relish.local_options_file).store(@cli_options)
      end
      
    end
  end
end