# simple Puppet file to install SplunkServer

host { 'splunkclient.localdomain':
  ensure       => 'present',
  host_aliases => ['splunkclient'],
  ip           => '10.0.0.11',
  target       => '/etc/hosts',
}

include ::splunk

