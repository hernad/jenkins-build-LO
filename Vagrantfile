# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

 config.vm.box = "ubuntu-12.04-i386"

  config.persistent_storage.enabled = true
  config.persistent_storage.location = "./data.vdi"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "2048"
  end

  config.vm.provision "shell", path: "build.sh"

end
