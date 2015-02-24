# == Class: kibana4
#
# Installation
#
class kibana4::install {

  if $kibana4::install_method == 'archive' {
    archive { "kibana-${kibana4::version}":
      ensure   => present,
      checksum => false,
      target   => $kibana4::install_dir,
      url      => $kibana4::download_url,
    }

    if $kibana4::symlink {
      file { $kibana4::symlink_name:
        ensure  => link,
        require => Archive["kibana-${kibana4::version}"],
        target  => "${kibana4::install_dir}/kibana-${kibana4::version}",
      }
    }
  }

  if $kibana4::install_method == 'package' {
    package { 'kibana4':
      ensure => $kibana4::version,
    }
  }

}
