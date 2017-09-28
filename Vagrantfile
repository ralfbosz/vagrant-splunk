# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "server" do |server|
    server.vm.box = "puppetlabs/centos-7.0-64-puppet"
    server.vm.network "forwarded_port", guest: 8000, host: 8000
    server.vm.network "forwarded_port", guest: 8089, host: 8089

    server.vm.provider "virtualbox" do |vb|
      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end

    server.vm.provision "file", source: "splunk-server.pp", destination: "/tmp/splunk-server.pp"
    server.vm.provision "file", source: "splunk-7.0.0-c8a78efdd40f-linux-2.6-x86_64.rpm", destination: "/tmp/splunk/linux/splunk-7.0.0-c8a78efdd40f-linux-2.6-x86_64.rpm"
    server.vm.provision "shell", inline: "puppet module install puppet-splunk"
    server.vm.provision "shell", inline: "puppet apply /tmp/splunk-server.pp"
    server.vm.provision "shell", inline: "firewall-cmd --zone=public --add-port=8000/tcp"
    server.vm.provision "shell", inline: "firewall-cmd --zone=public --add-port=8089/tcp"
  end

  config.vm.define "client" do |client|
    client.vm.box = "puppetlabs/centos-7.0-64-puppet"
    client.vm.provision "file", source: "splunk-client.pp", destination: "/tmp/splunk-client.pp"
    client.vm.provision "file", source: "splunkforwarder-7.0.0-c8a78efdd40f-linux-2.6-x86_64.rpm", destination: "/tmp/universalforwarder/linux/splunkforwarder-7.0.0-c8a78efdd40f-linux-2.6-x86_64.rpm"
    client.vm.provision "shell", inline: "puppet module install puppet-splunk"
    client.vm.provision "shell", inline: "puppet apply /tmp/splunk-client.pp"
  end
end
