# vagrant-cloudinit

A vagrant provisioner plugin for using cloud-init to bootstrap a compatible machine.

It works by creating the appropriate cloud-init ISO image and attaching it to the machine prior to boot.

**NOTE: This plugin currently only works with VirtualBox provider. PRs are welcome :)**

## Dependencies
vagrant-cloudinit depends on the `mkisofs` utility:
 - Ubuntu: `sudo apt install mkisofs`
 - Mac Homebrew: `brew install dvdrtools`
 - Mac Ports: `sudo port install cdrtools`

## Installation
```bash
vagrant plugin install vagrant-cloudinit
```

## Usage
```ruby
  config.vm.provision :cloud_init,
       wait: true,
       user_data: "./user-data.yml",
       meta_data: "./meta-data.yml"
```

### Options
 - `wait` (default: false): If true, the provisioner will block until cloud-init has finished bootstrapping.
 - `user_data` (required): The path to the user-data file
 - `meta_data` (optional): The path to the meta-data file.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jameskeane/vagrant-cloudinit.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

