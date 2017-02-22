# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tori/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "tori-rails"
  spec.version       = Tori::Rails::VERSION
  spec.authors       = ["asonas"]
  spec.email         = ["hzw1258@gmail.com"]

  spec.summary       = %q{tori with rails}
  spec.description   = %q{tori with rails}
  spec.homepage      = "https://github.com/asonas/tori-rails"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'tori'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
