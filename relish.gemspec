Gem::Specification.new do |s|
  s.name = "relish"
  s.version = "0.0.1"

  s.required_rubygems_version = '>= 1.3.5'
  s.authors = ["Matt Patterson", "Matt Wynne", "Justin Ko"]
  s.date = "2010-09-23"
  s.description = %q{Client gem for http://relishapp.com}
  s.email = "jko170@gmail.com"

  s.homepage = "http://relishapp.com"
  s.rdoc_options = ["--charset=UTF-8"]
  s.rubygems_version = "1.3.6"
  s.summary = %q{Client gem for http://relishapp.com}
  
  s.require_path = "lib"
  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- {spec,features}/*`.split("\n")
  
  {
    'bundler'             => '~> 1.0.0',
    'rake'                => '~> 0.8.7',
    'archive-tar-minitar' => '~> 0.5.2',
    'rest-client'         => '~> 1.6.1',
    'trollop'             => '~> 1.16.2',
    'rspec'               => '~> 2.0.0.beta.22',
    'cucumber'            => '~> 0.8.5',
    'aruba'               => '~> 0.2.1'
  }.each do |lib, version|
    s.add_development_dependency lib, version
  end
end