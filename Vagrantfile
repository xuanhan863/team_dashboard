# -*- mode: ruby -*-
# vi: set ft=ruby :

#FIXME Wait forever the machine to boot
#BOX_NAME = ENV["BOX_NAME"] || "raring64"
#BOX_URI = ENV["BOX_URI"] || "https://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"
BOX_NAME = ENV["BOX_NAME"] || "precise64"
BOX_URI = ENV["BOX_URI"] || "http://files.vagrantup.com/precise64.box"

Vagrant::Config.run do |config|
    config.vm.box = BOX_NAME
    config.vm.box_url = BOX_URI
    config.vm.forward_port 5000, 3000
    config.vm.provision :puppet do |puppet|
        # It's default location so not needed but hey, I learn
        puppet.manifests_path = "manifests"
        puppet.manifest_file = "default.pp"
    end
end
