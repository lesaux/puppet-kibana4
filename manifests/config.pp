# == Class: kibana4
#
# Configuration
#

class kibana4::config {

  # This should really be fixed at the kibana package level. There is no reason not to have
  # these files owned by Kibana as it makes installing plugins much more seamless.
  file { 'fix-optimize-bundles':
    ensure  => directory,
    path    => '/opt/kibana/optimize',
    recurse => true,
    owner   => $kibana4::kibana4_user,
    mode    => '0644',
  }

  file { 'kibana-config-file':
    ensure  => file,
    path    => '/opt/kibana/config/kibana.yml',
    owner   => $kibana4::kibana4_user,
    group   => $kibana4::kibana4_group,
    mode    => '0644',
    content => template('kibana4/kibana.yml.erb'),
    notify  => Service['kibana4'],
  }

}
