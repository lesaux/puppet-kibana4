# == Class: kibana4
#
# Configuration
#
class kibana4::config {

  if $kibana4::config {

    file { 'kibana-config-file':
      ensure  => file,
      path    => $kibana4::config_file,
      owner   => $kibana4::config_file_owner,
      group   => $kibana4::config_file_group,
      mode    => '0644',
      content => template('kibana4/kibana.yml.erb'),
      notify  => Service['kibana4'],
    }
  }

}
