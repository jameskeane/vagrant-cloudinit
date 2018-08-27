# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-cloudinit/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-cloudinit"
  spec.version       = VagrantPlugins::CloudInit::VERSION
  spec.authors       = ["James Keane"]
  spec.email         = ["james.keane@gmail.com"]

  spec.summary       = "A vagrant provisioner plugin for using cloud-init to bootstrap"
  spec.description   = "A vagrant provisioner plugin for using cloud-init to bootstrap"
  spec.homepage      = "https://github.com/jameskeane/vagrant-cloudinit"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
