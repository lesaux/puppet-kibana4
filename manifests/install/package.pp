# == Class: kibana
#
# Package Installation Method
#
class kibana::install::package {

  if ($kibana::manage_repo) {

    case $::osfamily {

      'RedHat': {
        yumrepo { "kibana-${kibana::package_repo_version}":
          baseurl  => "http://artifacts.elastic.co/kibana/${kibana::package_repo_version}/yum",
          enabled  => '1',
          gpgcheck => '1',
          gpgkey   => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
          descr    => "Kibana repository for ${kibana::package_repo_version}.x packages",
          proxy    => $kibana::package_repo_proxy,
          before   => Package['kibana'],
        }
      }

      'Debian': {
        if !defined(Class['apt']) {
          class { 'apt': }
        }
        apt::source { "kibana-${kibana::package_repo_version}":
          location => "http://artifacts.elastic.co/kibana/${kibana::package_repo_version}/apt",
          release  => 'stable',
          repos    => 'main',
          key      => {
            'source' => 'http://artifacts.elastic.co/GPG-KEY-elasticsearch',
            'id'     => '46095ACC8548582C1A2699A9D27D666CD88E42B4',
          },
          include  => {
            'src' => false,
          },
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
    name   => kibana,
  }
}
