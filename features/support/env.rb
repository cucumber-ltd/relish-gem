$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'relish/command'

Relish::Command::Base.class_eval do
  remove_const(:GLOBAL_OPTIONS_FILE)
  const_set(:GLOBAL_OPTIONS_FILE, '~/.relish')
end