# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    #step 2, you put your dist in the box
    config.vm.box = "ubuntu/trusty32"

    # Create a private network, which allows host-only access to the machine using a specific IP.
    config.vm.network :private_network, ip: "192.168.56.2"

    #forward ports to host
    config.vm.network :forwarded_port, guest: 80, host: 8080
	config.vm.network :forwarded_port, guest: 3000, host: 3000
	config.vm.network :forwarded_port, guest: 3001, host: 3001
	config.vm.network :forwarded_port, guest: 9000, host: 9000

	#apt-get ALL the things
    config.vm.provision :shell, :path => "provision/base.sh"
    config.vm.provision :shell, :path => "provision/lamp.sh"
    #config.vm.provision :shell, :path => "provision/python.sh"
    #config.vm.provision :shell, :path => "provision/ruby.sh"
    #config.vm.provision :shell, :path => "provision/node.sh"
    config.vm.provision :shell, inline: "sudo chown -R vagrant /home/vagrant"

    # If true, then any SSH connections made will enable agent forwarding.
    # Default value: false
    # config.ssh.forward_agent = true

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../data", "/vagrant_data"
    config.vm.synced_folder "./app", "/var/www/app", :mount_options => ["dmode=777", "fmode=777"]

    #memory settings for vm
    config.vm.provider "virtualbox" do |v|
      v.memory = 2048
    end

end
