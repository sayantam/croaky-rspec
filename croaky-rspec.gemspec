# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'croaky/version'

Gem::Specification.new do |spec|
  spec.name          = 'croaky-rspec'
  spec.version       = Croaky::VERSION
  spec.authors       = ['Sayantam Dey']
  spec.email         = ['sayantam@gmail.com']

  spec.summary       = 'RSpec formatter that croaks only for failed examples.'
  spec.description   = <<-DESC
  RSpec formatter that captures stdout and stderr during an example run, and dumps them for failed examples only.
  Progress is shown as per progress formatter.
  DESC
  spec.homepage      = 'https://github.com/sayantam/croaky-rspec'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/sayantam/croaky-rspec'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
