# == Class: kibana4
#
# Configuration
#
class kibana4::config {

  if $kibana4::config {

    file { 'kibana-config-file':
      ensure  => file,
      path    => $kibana4::config_path,
      owner   => 'kibana',
      group   => 'kibana',
      mode    => '0755',
      content => template('kibana4/kibana.yml.erb'),
      notify  => Service['kibana4'],
    }
  }

}
