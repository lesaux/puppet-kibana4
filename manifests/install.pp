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

    case $kibana4::archive_provider {
      'nanliu','puppet': {

        if $kibana4::package_proxy_server {
          fail("Setting a proxy server for archive download is not supported when \$archive_provider is '${kibana4::archive_provider}'")
        }

        archive { "${kibana4::install_dir}/kibana-${version}.tar.gz":
          ensure        => present,
          user          => 'root',
          group         => 'root',
          source        => $download_url,
          extract_path  => $kibana4::install_dir,
          # Extract files as the user doing the extracting, which is the user
          # that runs Puppet, usually root
          extract_flags => '-x --no-same-owner -f',
          creates       => "${kibana4::install_dir}/kibana-${version}",
          extract       => true,
          cleanup       => true,
          notify        => Exec['chown_kibana_directory'],
        }

        $symlink_require = Archive["${kibana4::install_dir}/kibana-${version}.tar.gz"]
      }
      'camptocamp': {
        archive { "kibana-${version}":
          ensure       => present,
          checksum     => false,
          target       => $kibana4::install_dir,
          url          => $download_url,
          proxy_server => $kibana4::package_proxy_server,
          notify       => Exec['chown_kibana_directory'],
        }

        $symlink_require = Archive["kibana-${version}"]
      }
      default: {
        fail("Unsupported \$archive_provider '${kibana4::archive_provider}'. Should be 'camptocamp' or 'nanliu' (aka 'puppet').")
      }
    }

    exec { 'chown_kibana_directory':
      command     => "chown -R ${kibana4::kibana4_user}:${kibana4::kibana4_group} ${kibana4::install_dir}/kibana-${version}",
      path        => ['/bin','/sbin'],
      refreshonly => true,
      require     => $symlink_require,
    }

    if $kibana4::symlink {
      file { $kibana4::symlink_name:
        ensure  => link,
        require => $symlink_require,
        target  => "${kibana4::install_dir}/kibana-${version}",
        owner   => $kibana4::kibana4_user,
        group   => $kibana4::kibana4_group,
      }
    }
  }

  if $kibana4::package_provider == 'package' {

    if $kibana4::use_official_repo {

      case $::osfamily {
        'RedHat': {
          yumrepo { "kibana-${kibana4::repo_version}":
            baseurl  => "http://packages.elastic.co/kibana/${kibana4::repo_version}/centos",
            enabled  => '1',
            gpgcheck => '1',
            gpgkey   => 'https://packages.elastic.co/GPG-KEY-elasticsearch',
            descr    => "Kibana repository for ${kibana4::repo_version}.x packages",
            before   => Package['kibana4'],
          }
        }
        'Debian': {
          if !defined(Class['apt']) {
            class { 'apt': }
          }
          apt::source { "kibana-${kibana4::repo_version}":
            location => "http://packages.elastic.co/kibana/${kibana4::repo_version}/debian",
            release  => 'stable',
            repos    => 'main',
            key      => {
              'source' => 'http://packages.elastic.co/GPG-KEY-elasticsearch',
              'id'     => '46095ACC8548582C1A2699A9D27D666CD88E42B4'
            },
            include  => {
              'src' => false
            },
            before   => Package['kibana4'],
          }
        }
        default: {
          fail("${::operatingsystem} not supported")
        }
      }

    }

    package { 'kibana4':
      ensure => $kibana4::package_ensure,
      name   => $kibana4::package_name,
    }

  }

}
