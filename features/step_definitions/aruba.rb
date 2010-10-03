require 'aruba'
gem_bin_path = File.dirname(__FILE__) + '/../../bin'
ENV['PATH'] = "#{gem_bin_path}:#{ENV['PATH']}"