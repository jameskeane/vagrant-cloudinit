begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant CloudInit plugin must be run within Vagrant."
end
require 'tempfile'


module VagrantPlugins
  module CloudInit
    VERSION = "0.0.1"

    class Plugin < Vagrant.plugin("2")
      name "CloudInit"
      description <<-DESC
      The user-data plugin allows a VM to be created using cloud-init.
      DESC

      config(:cloud_init, :provisioner) do
        class CloudInitConfig < Vagrant.plugin("2", :config)
          attr_accessor :user_data
          attr_accessor :meta_data
          attr_accessor :wait
        end
        CloudInitConfig
      end

      provisioner :cloud_init do
        class CloudInitProvisioner < Vagrant.plugin("2", :provisioner)

          def initialize(machine, config)
            super(machine, config)
          end

          def configure(root_config)
            user_data = File.expand_path(config.user_data)
            meta_data = ensure_metadata()

            iso_file = Tempfile.new(['nocloud', '.iso'])
            system("mkisofs",
                      "-joliet", "-rock",
                      "-volid", "cidata",
                      "-output", iso_file.path,
                      "-graft-points",
                      "user-data=#{user_data}",
                      "meta-data=#{meta_data}")

            # TODO add support for other providers
            if machine.provider_name == :virtualbox then
              machine.provider.driver.execute_command [
                  "storageattach", machine.id.to_s,
                  "--storagectl", "SCSI",
                  "--port", "2",
                  "--device", "0",
                  "--type", "dvddrive",
                  "--medium", iso_file.path.to_s
              ]
            end
          end

          def provision
            return unless config.wait
            machine.communicate.test("cloud-init status -w")
          end

          def cleanup
          end

          def ensure_metadata
            return File.expand_path(config.meta_data) if config.meta_data

            # Create another temp file, and fill it with generic metadata
            meta_file = Tempfile.new()
            File.write(meta_file.path, "{\n\"instance-id\": \"#{machine.id}\"\n}")
            return meta_file.path
          end

        end

        CloudInitProvisioner
      end
    end
  end
end
