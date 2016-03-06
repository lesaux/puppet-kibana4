# == Class: kibana4
#
# Archive Installation Method
#
class kibana4::install::archive {

  $package_name = $kibana4::package_name

  $download_url = $kibana4::package_download_url ? {
    undef   => "${kibana4::params::es_download_site_url}/kibana/kibana/${package_name}-${kibana4::version}.tar.gz",
    default => $kibana4::package_download_url,
  }

  case $kibana4::archive_provider {
    'nanliu','puppet': {

      if $kibana4::package_proxy_server {
        fail("Setting a proxy server for archive download is not supported when \$archive_provider is '${kibana4::archive_provider}'")
      }

      archive { "${kibana4::install_dir}/kibana-${kibana4::version}.tar.gz":
        ensure        => present,
        user          => 'root',
        group         => 'root',
        source        => $download_url,
        extract_path  => $kibana4::install_dir,
        # Extract files as the user doing the extracting, which is the user
        # that runs Puppet, usually root
        extract_flags => '-x --no-same-owner -f',
        creates       => "${kibana4::install_dir}/kibana-${kibana4::version}",
        extract       => true,
        cleanup       => true,
        notify        => Exec['chown_kibana_directory'],
      }

      $symlink_require = Archive["${kibana4::install_dir}/kibana-${kibana4::version}.tar.gz"]

    }

    'camptocamp': {
      archive { "kibana-${kibana4::version}":
        ensure       => present,
        checksum     => false,
        verbose      => false,
        target       => $kibana4::install_dir,
        url          => $download_url,
        proxy_server => $kibana4::package_proxy_server,
        timeout      => $kibana4::archive_dl_timeout,
        notify       => Exec['chown_kibana_directory'],
      }

      $symlink_require = Archive["kibana-${kibana4::version}"]

    }

    default: {
      fail("Unsupported \$archive_provider '${kibana4::archive_provider}'. Should be 'camptocamp' or 'nanliu' (aka 'puppet').")
    }

  }

  exec { 'chown_kibana_directory':
    command     => "chown -R ${kibana4::kibana4_user}:${kibana4::kibana4_group} ${kibana4::install_dir}/kibana-${kibana4::version}",
    path        => ['/bin','/sbin'],
    refreshonly => true,
    require     => $symlink_require,
  }

  if $kibana4::symlink {

    file { $kibana4::symlink_name:
      ensure  => link,
      require => $symlink_require,
      target  => "${kibana4::install_dir}/kibana-${kibana4::version}",
      owner   => $kibana4::kibana4_user,
      group   => $kibana4::kibana4_group,
    }

  }

}
