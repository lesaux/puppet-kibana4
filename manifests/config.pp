# == Class: kibana4
#
# Configuration
#

class kibana4::config {

  file { 'fix-optimize-bundles':
    ensure  => directory,
    path    => '/opt/kibana/optimize',
    recurse => true,
    owner   => $kibana4::kibana4_user,
    mode    => '0755',
  }

  file { 'kibana-config-file':
    ensure  => file,
    path    => '/opt/kibana/config/kibana.yml',
    owner   => $kibana4::kibana4_user,
    group   => $kibana4::kibana4_group,
    mode    => '0755',
    content => template('kibana4/kibana.yml.erb'),
    notify  => Service['kibana4'],
  }

}
