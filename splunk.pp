# simple Puppet file to install SplunkServer
# simple Puppet file to install SplunkServer
class { '::splunk::params':
  version => '7.0.0',
  build => 'c8a78efdd40f',
  src_root => '/tmp',
}

include ::splunk

