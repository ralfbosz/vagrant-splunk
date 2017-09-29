# simple Puppet file to install SplunkClient

host { 'splunkserver.localdomain':
  ensure       => 'present',
  host_aliases => ['splunkserver'],
  ip           => '10.0.0.10',
  target       => '/etc/hosts',
}

class { '::splunk::params':
  server   => 'splunkserver.localdomain',
  version  => '7.0.0',
  build    => 'c8a78efdd40f',
  src_root => '/tmp',
  require  => Host['splunkserver.localdomain'],
}

include ::splunk::forwarder

