# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "rollbar-notification-rules-generator"
  spec.version = `ruby -Ilib exe/rollbar-notification-rules-generator --version`.split(" ").last.chomp
  spec.authors = ["abicky"]
  spec.email = ["takeshi.arabiki@gmail.com"]

  spec.summary = "A CLI tool that generates Rollbar notification rules that are mutually exclusive from a simple YAML file"
  spec.description = "This tool generates Rollbar notification rules that are mutually exclusive from a simple YAML file."

  spec.homepage = "https://github.com/abicky/rollbar-notification-rules-generator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/abicky/rollbar-notification-rules-generator"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
