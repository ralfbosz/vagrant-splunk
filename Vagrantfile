# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "server" do |server|
    server.vm.box = "puppetlabs/centos-7.0-64-puppet"
    server.vm.hostname = "splunkserver.local"
    server.vm.network :private_network, ip: "10.0.0.10"
    server.vm.network "forwarded_port", guest: 8000, host: 8000

    server.vm.provider "virtualbox" do |vb|
      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end

    server.vm.provision "shell", inline: "puppet module install puppet-splunk"
    server.vm.provision "puppet" do |puppet|
      puppet.hiera_config_path = "hiera.yaml"
      puppet.manifest_file = "server.pp"
    end
    server.vm.provision "shell", inline: "firewall-cmd --zone=public --add-port=8000/tcp"
    server.vm.provision "shell", inline: "firewall-cmd --zone=public --add-port=9997/tcp"
  end

  config.vm.define "client" do |client|
    client.vm.box = "puppetlabs/centos-7.0-64-puppet"
    client.vm.hostname = "splunkclient.local"
    client.vm.network :private_network, ip: "10.0.0.11"
    client.vm.provision "shell", inline: "puppet module install puppet-splunk"
    client.vm.provision "puppet" do |puppet|
      puppet.hiera_config_path = "hiera.yaml"
      puppet.manifest_file = "client.pp"
    end
  end
end
