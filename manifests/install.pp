# == Class: kibana
#
# Installation
#
class kibana::install {
  if ($kibana::manage_repo) {
    if versioncmp($kibana::package_repo_version, '5.0') >= 0 {
      $apt_repo_url = 'https://artifacts.elastic.co/packages/5.x/apt'
      $yum_repo_url = 'https://artifacts.elastic.co/packages/5.x/yum'
    } else {
      $apt_repo_url = "https://artifacts.elastic.co/kibana/${kibana::package_repo_version}/debian"
      $yum_repo_url = "https://artifacts.elastic.co/kibana/${kibana::package_repo_version}/yum"
    }

    case $::osfamily {
      'RedHat': {
        yumrepo { 'kibana':
          baseurl  => $yum_repo_url,
          enabled  => '1',
          gpgcheck => '1',
          gpgkey   => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
          descr    => 'Kibana repository',
          proxy    => $kibana::package_repo_proxy,
          before   => Package['kibana'],
        }
      }

      'Debian': {
        if !defined(Class['apt']) {
          class { 'apt': }
        }

        apt::source { 'kibana':
          location => $apt_repo_url,
          release  => 'stable',
          repos    => 'main',
          key      => {
            source => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
            id     => '46095ACC8548582C1A2699A9D27D666CD88E42B4',
          },
          include  => {
            src => false,
          },
          before   => Package['kibana'],
        }

        apt::pin { 'kibana':
          packages => 'kibana',
          priority => 700,
          version  => "${kibana::package_repo_version}.*",
          before   => Package['kibana'],
        }
      }

      default: {
        fail("${::operatingsystem} not supported")
      }
    }
  }

  package { 'kibana':
    ensure => $kibana::version,
    notify => Service['kibana'],
  }

}
