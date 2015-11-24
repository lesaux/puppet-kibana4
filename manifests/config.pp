# == Class: kibana4
#
# Configuration
#
class kibana4::config {

  $version = $kibana4::package_ensure

  if $kibana4::config_file {
    $_config_file = $kibana4::config_file
  } elsif $kibana4::package_provider == 'archive' {
    $_config_file = "${kibana4::install_dir}/kibana-${version}/config/kibana.yml"
  } elsif $kibana4::package_provider == 'package' {
    $_config_file = "${kibana4::install_dir}/${kibana4::package_name}/config/kibana.yml"
  }

  file { 'kibana-config-file':
    ensure  => file,
    path    => $_config_file,
    owner   => $kibana4::kibana4_user,
    group   => $kibana4::kibana4_group,
    mode    => '0755',
    content => template('kibana4/kibana.yml.erb'),
    notify  => Service['kibana4'],
  }

  if $kibana4::package_provider == 'archive' {
    file {$kibana4::pid_file:
      ensure => file,
      owner  => $kibana4::kibana4_user,
      group  => $kibana4::kibana4_group,
      mode   => '0644',
    }
  }

}
