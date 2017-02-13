# == Class: kibana
#
# Configuration
#
class kibana::config {

  if $kibana::config {

    file { 'kibana-config-file':
      ensure  => file,
      path    => '/etc/kibana/kibana.yml',
      owner   => 'kibana',
      group   => 'kibana',
      mode    => '0755',
      content => template('kibana/kibana.yml.erb'),
      notify  => Service['kibana'],
    }
  }

}
