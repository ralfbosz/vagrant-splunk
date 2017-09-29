# simple Puppet file to install SplunkServer

host { 'splunkclient.localdomain':
  ensure       => 'present',
  host_aliases => ['splunkclient'],
  ip           => '10.0.0.11',
  target       => '/etc/hosts',
}

class { '::splunk::params':
  version  => '7.0.0',
  build    => 'c8a78efdd40f',
  src_root => '/tmp',
  require  => Host['splunkclient.localdomain'],
}

include ::splunk

