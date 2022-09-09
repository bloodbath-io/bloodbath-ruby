# frozen_string_literal: true

require_relative "lib/bloodbath/version"

Gem::Specification.new do |spec|
  spec.name = "bloodbath"
  spec.version = Bloodbath::VERSION
  spec.authors = ["Laurent Schaffner"]
  spec.email = ["laurent.schaffner.code@gmail.com"]

  spec.summary = "The Bloodbath Ruby library provides convenient access to the Bloodbath API" \
    "from applications written in the Ruby language."

  spec.homepage = "https://bloodbath.io"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")
  spec.post_install_message = "
  Thanks for installing Bloodbath! Have a good load testing.
  For more information please visit https://bloodbath.io"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/bloodbath-io/bloodbath-ruby"
  spec.metadata["changelog_uri"] = "https://rubygems.org/gems/bloodbath"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    %x(git ls-files -z).split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency("pry", "~> 0.14.1")
  spec.add_development_dependency("rake", "~> 13.0.6")
  spec.add_development_dependency("rspec", "~> 3.11.0")
  spec.add_development_dependency("rubocop", "~> 1.36.0")
  spec.add_development_dependency("rubocop-rake", "~> 0.6.0")
  spec.add_development_dependency("rubocop-rspec", "~> 2.12.1")
  spec.add_development_dependency("rubocop-shopify", "~> 2.9.0")
  spec.add_development_dependency("vcr", "~> 6.1.0")
  spec.add_development_dependency("webmock", "~> 3.18.1")
end
