# simple Puppet file to install SplunkClient

host { 'splunkserver.localdomain':
  ensure       => 'present',
  host_aliases => ['splunkserver'],
  ip           => '10.0.0.10',
  target       => '/etc/hosts',
}

include ::splunk::forwarder

@splunkforwarder_input { 'messages':
  section => 'monitor:///var/log/messages',
  setting => 'sourcetype',
  value   => 'puppetclient',
  tag     => 'messages',
}

