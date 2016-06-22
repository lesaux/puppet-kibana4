# == Class: kibana4
#
# Configuration
#
class kibana4::config {

    $_config_file = '/opt/kibana/config/kibana.yml'

  if $kibana4::config {

    file { 'kibana-config-file':
      ensure  => file,
      path    => $_config_file,
      mode    => '0755',
      content => template('kibana4/kibana.yml.erb'),
      notify  => Service['kibana4'],
    }

  }

}
