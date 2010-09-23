Gem::Specification.new do |s|
  s.name = "relish"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Patterson", "Matt Wynne", "Justin Ko"]
  s.date = "2010-09-23"
  s.description = %q{Client gem for http://relishapp.com}
  s.email = "matt@reprocessed.org"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = Dir.glob([
    "VERSION",
    "README.md",
    "LICENSE",
    "Rakefile",
    "lib/**/*.rb",
  ])
  s.homepage = "http://relishapp.com"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.6"
  s.summary = %q{Client gem for http://relishapp.com}
  s.test_files = Dir.glob([
    "spec/spec.opts",
    "spec/**/*.rb",
    "features/**/*.rb",
    "features/**/*.feature"
  ])
  
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3
    
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<cucumber>, [">= 0.5"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<cucumber>, [">= 0.5"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<cucumber>, [">= 0.5"])
  end
end