# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shopify_api_mixins/version'

Gem::Specification.new do |spec|
  spec.name          = "shopify_api_mixins"
  spec.version       = ShopifyApiMixins::VERSION
  spec.authors       = ["Michael Hewson"]
  spec.email         = ["michael@michaelhewson.ca"]

  spec.summary       = %q{Useful mixins for working with the shopify_api gem}
  spec.homepage      = "https://github.com/mikeyhew/shopify_api_mixins"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "shopify_api", ">= 4.3.1"
  spec.add_runtime_dependency "activeresource", ">= 5.0"
end
