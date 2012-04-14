# -*- encoding: utf-8 -*-
require File.expand_path('../lib/caule/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rafael Souza"]
  gem.email         = ["me@rafaelss.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "caule"
  gem.require_paths = ["lib"]
  gem.version       = Caule::VERSION

  gem.add_dependency "mechanize", "~> 2.3"
  gem.add_development_dependency "rspec", "~> 2.9.0"
  gem.add_development_dependency "fivemat", "~> 1.0.0"
  gem.add_development_dependency "webmock", "~> 1.8.6"
end
