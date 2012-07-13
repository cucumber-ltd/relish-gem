$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'relish/version'

Gem::Specification.new do |s|
  s.name = "relish"
  s.version = Relish::Version::STRING

  s.required_rubygems_version = '>= 1.3.5'
  s.authors = ["Matt Wynne", "Justin Ko"]
  s.date = Date.today
  s.description = %q{Client gem for http://relishapp.com}
  s.email = "matt@mattwynne.net"

  s.homepage = "http://relishapp.com"
  s.rdoc_options = ["--charset=UTF-8"]
  s.rubygems_version = "1.3.6"
  s.summary = %q{Client gem for http://relishapp.com}

  s.require_path = "lib"
  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables  = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  {
    'archive-tar-minitar' => '>= 0.5.2',
    'rest-client'         => '>= 1.6.1',
    'json'                => '>= 1.4.6'
  }.each do |lib, version|
    s.add_runtime_dependency lib, version
  end

  {
    'bundler'             => '~> 1.2.0.pre.1',
    'rake'                => '~> 0.8.7',
    'rspec'               => '~> 2.8.0',
    'cucumber'            => '~> 1.0.2',
    'aruba'               => '~> 0.4.5',
    'fakeweb'             => '~> 1.3.0'
  }.each do |lib, version|
    s.add_development_dependency lib, version
  end
end
