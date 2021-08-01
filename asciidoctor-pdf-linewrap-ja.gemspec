lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "asciidoctor/pdf/linewrap/ja/version"

Gem::Specification.new do |spec|
  spec.name          = "asciidoctor-pdf-linewrap-ja"
  spec.version       = Asciidoctor::Pdf::Linewrap::Ja::VERSION
  spec.authors       = ["y.fukazawa"]
  spec.email         = ["fuka@backport.net"]

  spec.summary       = %q{Asciidoctor PDF extension providing better line wrap for Japanese document.}
  spec.homepage      = "https://github.com/fuka/asciidoctor-pdf-linewrap-ja"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "asciidoctor-pdf", "~> 1.6.0"
  spec.add_development_dependency "bundler", ">= 2.2.10"
  spec.add_development_dependency "rake", ">= 13.0.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
