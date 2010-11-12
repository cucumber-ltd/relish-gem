require 'rubygems'
require 'bundler'
Bundler.setup

require 'relish/command'

Dir['./spec/support/*.rb'].map {|f| require f }

RSpec.configure do |config|
  config.color_enabled = true
end