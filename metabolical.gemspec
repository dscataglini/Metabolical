# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "metabolical/version"

Gem::Specification.new do |s|
  s.name        = "metabolical"
  s.version     = Metabolical::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Diego Scataglini"]
  s.email       = ["dwebsubmit@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{This is an ActiveRecord Model & mixin to add meta data to any AR object}
  s.description = %q{This is an ActiveRecord Model & mixin to add meta data to any AR object}
  
  s.required_ruby_version = '>= 1.8.7'
  
  s.rubyforge_project = "metabolical"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('activerecord',  '>= 4.2.0')

end
