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
      ensure            => present,
      checksum          => false,
      target            => $kibana4::install_dir,
      url               => $download_url,
      proxy_server      => $kibana4::package_proxy_server,
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

    if $kibana4::use_official_repos {

      case $::osfamily {
        'RedHat': {
          yumrepo { "kibana-${kibana4::repo_version}":
            baseurl   => "http://packages.elastic.co/kibana/${kibana4::repo_version}/centos",
            enabled   => '1',
            gpgcheck  => '1',
            gpgkey    => 'https://packages.elastic.co/GPG-KEY-elasticsearch',
            descr     => "Kibana repository for ${kibana4::repo_version}.x packages",
            before    => Package['kibana4'],
          }
        }
        'Debian': {
          if !defined(Class['apt']) {
            class { 'apt': }
          }
          apt::source { "kibana-${kibana4::repo_version}":
            location    => "http://packages.elastic.co/kibana/${kibana4::repo_version}/debian",
            release     => 'stable',
            repos       => 'main',
            key         => 'D88E42B4',
            key_source  => 'http://packages.elastic.co/GPG-KEY-elasticsearch',
            include_src => false,
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
