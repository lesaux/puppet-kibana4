# == Class: Kibana4
#
# Installs and configures Kibana4.
#
# === Parameters
# [*version*]
# Version of Kibana4 that gets installed.
# Defaults to the latest 4.0.0 version available at the time of module release.
#
# [*install_method*]
# Set to 'archive' to download kibana from the supplied download_url.
# Set to 'package' to use the default package manager for installation.
# Defaults to 'archive'.
#
# [*download_url*]
# URL to download kibana from iff install_method is 'archive'
# Defaults to "https://download.elasticsearch.org/kibana/kibana/kibana-${version}.tar.gz"
#
# [*install_dir*]
# Installation directory used iff install_method is 'archive'
# Defaults to '/opt'.
#
# [*symlink*]
# Determines if a symlink should be created in the installation directory for
# the extracted archive. Only used if install_method is 'archive'.
# Defaults to 'true'.
#
# [*symlink_name*]
# Sets the name to be used for the symlink. The default is '${install_dir}/kibana'.
# Only used if install_method is 'archive'.
#
# [*kibana_user*]
# The user that will own the installation directory.
# The default is 'root' and there is no logic in place to check that the value
# specified is a valid user on the system.
#
# [*kibana_group*]
# The group that will own the installation directory.
# The default is 'root' and there is no logic in place to check that the value
# specified is a valid group on the system.
#
#
# === Examples
#
#  class { '::kibana4':
#    version         => '4.0.0-beta3',
#    install_method  => 'package',
#  }
#
class kibana4 (
  $download_url       = "https://download.elasticsearch.org/kibana/kibana/kibana-${version}.tar.gz",
  $kibana_group       = $kibana4::params::kibana_group,
  $kibana_user        = $kibana4::params::kibana_user,
  $install_dir        = $kibana4::params::install_dir,
  $install_method     = $kibana4::params::install_method,
  $symlink            = $kibana4::params::symlink,
  $symlink_name       = "${install_dir}/kibana",
  $version            = $kibana4::params::version,
) inherits kibana4::params {

  if $install_method == 'archive' {
    archive { "kibana-${version}":
      ensure   => present,
      checksum => false,
      target   => $install_dir,
      url      => $download_url,
    }

    $require_target = Archive["kibana-${version}"]
    #$config_js = "${install_dir}/kibana-${version}/config.js"

    if $symlink {
      file { $symlink_name:
        ensure  => link,
        require => Archive["kibana-${version}"],
        target  => "${install_dir}/kibana-${version}",
      }
    }
  }

  if $install_method == 'package' {
    package { 'kibana':
      ensure => $version,
    }

    #$config_js = "${install_dir}/config.js"
    $require_target = Package['kibana']
  }

  file { '/etc/init.d/kibana':
    ensure  => present,
    content => template('kibana4/kibana.init'),
    group   => $kibana_group,
    owner   => $kibana_user,
    require => $require_target,
  }

  service { 'kibana':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => File['/etc/init.d/kibana']
  }

}
