# == Class: kibana
#
# Configuration
#
class kibana::config {

  file { 'kibana.yml':
    ensure  => 'file',
    path    => $kibana::config_path,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('kibana/kibana.yml.erb'),
    notify  => Service['kibana'],
  }

}
