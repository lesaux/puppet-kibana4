# == Class: kibana4
#
# Configuration
#

class kibana4::config {

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
