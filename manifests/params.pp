# == Class: kibana
#
# Default parameters
#
class kibana::params {
  $version        = 'latest'
  $manage_repo    = true
  $service_ensure = 'running'
  $service_enable = true

  case $::operatingsystem {
    'Debian': {
      if versioncmp($::operatingsystemmajrelease, '8') >= 0 {
        $service_provider = 'systemd'
      } else {
        $service_provider = 'init'
      }
    }
    'RedHat': {
      if versioncmp($::operatingsystemmajrelease, '7') >= 0 {
        $service_provider = 'systemd'
      } else {
        $service_provider = 'init'
      }
    }
    'Ubuntu': {
      if versioncmp($::operatingsystemmajrelease, '15.10') > 0 {
        $service_provider = 'systemd'
      } else {
        $service_provider = 'init'
      }
    }
    default: {
      $service_provider = 'init'
    }
  }

  $config  = {}
  $plugins = {}
}
