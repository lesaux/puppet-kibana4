# == Class: kibana4
#
# Installation
#
class kibana4::install {

  if $kibana4::package_provider == 'archive' {
    $package_name = $kibana4::package_name
    $version      = $kibana4::package_ensure

    $download_url = $kibana4::package_download_url ? {
      undef   => "${kibana4::params::es_download_site_url}/kibana/kibana/${package_name}-${version}.tar.gz",
      default => $kibana4::package_download_url,
    }

    archive { "kibana-${version}":
      ensure   => present,
      checksum => false,
      target   => $kibana4::install_dir,
      url      => $download_url,
    }

    if $kibana4::symlink {
      file { $kibana4::symlink_name:
        ensure  => link,
        require => Archive["kibana-${version}"],
        target  => "${kibana4::install_dir}/kibana-${version}",
      }
    }
  }

  if $kibana4::package_provider == 'package' {
    package { 'kibana4':
      ensure => $kibana4::package_ensure,
      name   => $kibana4::package_name,
    }
  }

}
