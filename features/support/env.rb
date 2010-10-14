$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'relish/command'

Relish::Command::Base::GLOBAL_OPTIONS_FILE = '~/.relish'