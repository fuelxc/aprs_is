require_relative 'lib/aprs_is/version'

Gem::Specification.new do |spec|
  spec.name          = "aprs_is"
  spec.version       = AprsIs::VERSION
  spec.authors       = ["Eric Harrison"]
  spec.email         = ["eric@rubynooby.com"]

  spec.summary       = %q{Gem that implements the APRS-IS specification}
  spec.homepage      = "https://github.com/fuelxc/aprs_is"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/fuelxc/aprs_is"
  spec.metadata["changelog_uri"] = "https://github.com/fuelxc/aprs_is/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency 'terminal-notifier-guard', '~> 1.6.1'
  spec.add_development_dependency 'simplecov'
end
