node splunkclient.local {
  # simple Puppet file to install SplunkClient

  host { 'splunkserver.local':
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
}
node splunkserver.local {
  # simple Puppet file to install SplunkServer

  host { 'splunkclient.local':
    ensure       => 'present',
    host_aliases => ['splunkclient'],
    ip           => '10.0.0.11',
    target       => '/etc/hosts',
  }

  include ::splunk

}
