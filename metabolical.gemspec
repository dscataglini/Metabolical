lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "metabolical/version"

Gem::Specification.new do |spec|
  spec.name        = "metabolical"
  spec.version     = Metabolical::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ["Diego Scataglini"]
  spec.email       = ["dwebsubmit@gmail.com"]
  spec.homepage      = "https://github.com/dscataglini/Metabolical"
  spec.summary     = %q{This is an ActiveRecord Model & mixin to add meta data to any AR object}
  spec.description = %q{This is an ActiveRecord Model & mixin to add meta data to any AR object}
  spec.license     = "MIT"
  spec.required_ruby_version = '>= 3.2.0'
  
  spec.rubyforge_project = "metabolical"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('activerecord',  '>= 6.0.0')
  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  
  
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end
end
