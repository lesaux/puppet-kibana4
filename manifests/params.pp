# == Class: kibana
#
# Default parameters
#
class kibana::params {
  $babel_cache_path              = '/tmp/babel.cache'
  $version                       = 'latest'
  $manage_repo                   = true
  $package_repo_version          = '5.x'
  $package_install_dir           = '/usr/share/kibana'
  $service_ensure                = true
  $service_enable                = true
  $service_name                  = 'kibana'
  case $::osfamily {
    'Debian': { $service_provider = debian }
    'RedHat': {
      case $::operatingsystemmajrelease {
        '7': { $service_provider = systemd }
        default: { $service_provider = init }
      }
    }
    default: { $service_provider = init   }
  }
  $config                        = undef
}
