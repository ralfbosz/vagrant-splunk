# -*- mode: ruby -*-
# vi: set ft=ruby :

SPLUNK_VERSION = "7.0.0"
SPLUNK_BUILD = "c8a78efdd40f"

Vagrant.configure("2") do |config|

  config.vm.define "server" do |server|
    server.vm.box = "puppetlabs/centos-7.0-64-puppet"
    server.vm.hostname = "splunkserver.local"
    server.vm.network :private_network, ip: "10.0.0.10"
    server.vm.network "forwarded_port", guest: 8000, host: 8000
    server.vm.network "forwarded_port", guest: 8089, host: 8089

    server.vm.provider "virtualbox" do |vb|
      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end

    server.vm.provision "file", source: "splunk-#{SPLUNK_VERSION}-#{SPLUNK_BUILD}-linux-2.6-x86_64.rpm", destination: "/tmp/splunk/linux/splunk-#{SPLUNK_VERSION}-#{SPLUNK_BUILD}-linux-2.6-x86_64.rpm"
    server.vm.provision "file", source: "splunk-server.pp", destination: "/tmp/splunk-server.pp"
    server.vm.provision "shell", inline: "puppet module install puppet-splunk" 
    server.vm.provision "shell", inline: "puppet apply /tmp/splunk-server.pp"
    server.vm.provision "shell", inline: "firewall-cmd --zone=public --add-port=8000/tcp"
    server.vm.provision "shell", inline: "firewall-cmd --zone=public --add-port=8089/tcp"
  end

  config.vm.define "client" do |client|
    client.vm.box = "puppetlabs/centos-7.0-64-puppet"
    client.vm.hostname = "splunkclient.local"
    client.vm.network :private_network, ip: "10.0.0.11"
    client.vm.provision "file", source: "splunkforwarder-#{SPLUNK_VERSION}-#{SPLUNK_BUILD}-linux-2.6-x86_64.rpm", destination: "/tmp/universalforwarder/linux/splunkforwarder-#{SPLUNK_VERSION}-#{SPLUNK_BUILD}-linux-2.6-x86_64.rpm"
    client.vm.provision "file", source: "splunk-client.pp", destination: "/tmp/splunk-client.pp"
    client.vm.provision "shell", inline: "mkdir -p /etc/puppetlabs/code/environments/client"
    client.vm.provision "shell", inline: "puppet module install puppet-splunk"
    client.vm.provision "shell", inline: "puppet apply /tmp/splunk-client.pp"
  end
end
