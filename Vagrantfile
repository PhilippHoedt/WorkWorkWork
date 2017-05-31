# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "provolution/packer-lamp-deb"

  unless Vagrant.has_plugin?("vagrant-hostupdater")
    config.vm.hostname = "dev.work-work-work.de"
  end

  # API calls
  config.vm.network :forwarded_port, guest: 80, host: 8888

  config.vm.network :private_network, ip: "192.168.222.12"
  config.vm.synced_folder ".", "/var/www/project", :nfs => true
  config.ssh.forward_agent = true
  config.ssh.insert_key = false
  config.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
  end

  config.vm.provision "shell", path: "build/vagrant-provision/setup.sh"
end
