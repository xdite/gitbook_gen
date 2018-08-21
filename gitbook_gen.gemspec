
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gitbook_gen/version"

Gem::Specification.new do |spec|
  spec.name          = "gitbook_gen"
  spec.version       = GitbookGen::VERSION
  spec.authors       = ["xdite"]
  spec.email         = ["xdite@otcbtc.com"]

  spec.summary       = %q{Quick Gitbook Generator }
  spec.description   = %q{Quick Gitbook Generator }
  spec.homepage      = "https://github.com/xdite/gitbook_gen"
  spec.license       = "MIT"
  spec.executables << "gitbook_gen"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "thor"
  spec.add_dependency "activesupport"
end
