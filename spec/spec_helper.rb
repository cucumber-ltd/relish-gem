require 'rubygems'
require 'bundler'
Bundler.setup

require 'relish/command'

RSpec.configure do |config|
  config.color_enabled = true
  
  config.before(:suite) do
    Relish::Command::Base::GLOBAL_OPTIONS_FILE = '~/.relish'
  end
end