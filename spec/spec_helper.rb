require 'rubygems'
require 'bundler'
Bundler.setup

require 'relish/command'

RSpec.configure do |config|
  config.color_enabled = true
  
  config.before(:suite) do
    
    Relish::Command::Base.class_eval do
      remove_const(:GLOBAL_OPTIONS_FILE)
      const_set(:GLOBAL_OPTIONS_FILE, '~/.relish')
    end
    
  end
end