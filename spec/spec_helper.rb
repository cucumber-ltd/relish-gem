require 'rubygems'
require 'bundler'
Bundler.setup

require 'relish/command'

RSpec.configure do |config|
  config.color_enabled = true
end