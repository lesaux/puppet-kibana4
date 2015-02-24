# == Class: kibana4
#
# Service creation and mgmt
#
class kibana4::service {

  file { '/etc/init.d/kibana4':
    ensure  => present,
    mode    => '0755',
    content => template('kibana4/kibana.init'),
    group   => root,
    owner   => root,
  }

  service { 'kibana4':
    ensure     => $kibana4::ensure,
    enable     => $kibana4::enable,
    hasstatus  => true,
    hasrestart => true,
    require    => File['/etc/init.d/kibana4']
  }

}
