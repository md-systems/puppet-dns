class dns::server (
  $searchpath,
  $nameservers,
  $domainname = $domain,
  $options = undef,
  $location = $::location
) {
  include dnsmasq
  Dnsmasq::Address <<| tag == $location |>>

  @@file { 'resolv_conf':
    ensure  => file,
    path    => '/etc/resolv.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('dns/resolv.conf.erb'),
    tag     => $location,
  }

  file {'/etc/resolv.dnsmasq':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('dns/resolv.dnsmasq.erb'),
    notify => Class['dnsmasq'],
  }
}
