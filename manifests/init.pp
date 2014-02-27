class dns (
  $domains = [],
  $ip = $::ipaddress,
  $location = $::location
) {
  package {'resolvconf':
    ensure => absent,
  }

  @@dnsmasq::address {
    $fqdn: ip => $ip,
    tag => $::location,
  }
  each($domains) |$domain| {
    @@dnsmasq::address {
      $domain: ip => $ip,
      tag => $location,
    }
  }

  File <<| title == 'resolv_conf' and tag == $location |>> {
    require => Package['resolvconf'],
  }
}
