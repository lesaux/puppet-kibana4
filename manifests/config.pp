# == Class: kibana4
#
# Configuration
#
class kibana4::config {

  if $kibana4::config_file {
    $_config_file = $kibana4::config_file
  } elsif $kibana4::install_method == 'archive' {
    $_config_file = "${kibana4::install_dir}/kibana-${kibana4::version}/config/kibana.yml"
  } elsif $kibana4::install_method == 'package' {
    $_config_file = "${kibana4::install_dir}/${kibana4::package_name}/config/kibana.yml"
  }

  if $kibana4::config {

    file { 'kibana-config-file':
      ensure  => file,
      path    => $_config_file,
      owner   => $kibana4::kibana4_user,
      group   => $kibana4::kibana4_group,
      mode    => '0755',
      content => template('kibana4/kibana.yml.erb'),
      notify  => Service['kibana4'],
    }

  }

# Log dir is now created and chowned by init script
#  file { '/var/log/kibana':
#    ensure => 'directory',
#    owner  => $kibana4::kibana4_user,
#    group  => $kibana4::kibana4_group,
#    mode   => '0755',
#  }

}
