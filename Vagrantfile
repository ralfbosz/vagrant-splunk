# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "server" do |server|
    server.vm.box = "centos/7"
    server.vm.hostname = "splunkserver.local"
    server.vm.network :private_network, ip: "10.0.0.10"
    server.vm.network "forwarded_port", guest: 8000, host: 8000

    server.vm.provider "virtualbox" do |vb|
      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end
  end

  config.vm.define "client" do |client|
    client.vm.box = "centos/7"
    client.vm.hostname = "splunkclient.local"
    client.vm.network :private_network, ip: "10.0.0.11"
  end

  config.vm.provision "shell", path: "scripts/install-puppet.sh"
  config.vm.provision "puppet" do |puppet|
    puppet.hiera_config_path = "hiera.yaml"
    puppet.manifest_file = "splunk.pp"
  end

end
