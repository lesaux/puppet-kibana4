# == Class: Kibana4
#
# Installs and configures Kibana4.
#
# === Parameters
# [*ensure*]
# Should the service be started. Valid values are stopped (false) and running (true)
#
# [*enable*]
# Should the service be enabled on boot. Valid values are true, false, and manual.
#
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
#    version         => '4.0.0',
#    install_method  => 'package',
#  }
#
class kibana4 (
  $download_url       = "https://download.elasticsearch.org/kibana/kibana/kibana-${version}.tar.gz",
  $create_user        = $kibana4::params::create_user,
  $ensure             = $kibana4::params::ensure,
  $enable             = $kibana4::params::enable,
  $kibana4_group      = $kibana4::params::kibana_group,
  $kibana4_gid        = $kibana4::params::kibana_gid,
  $kibana4_user       = $kibana4::params::kibana_user,
  $kibana4_uid        = $kibana4::params::kibana_uid,
  $install_dir        = $kibana4::params::install_dir,
  $install_method     = $kibana4::params::install_method,
  $symlink            = $kibana4::params::symlink,
  $symlink_name       = "${install_dir}/kibana4",
  $version            = $kibana4::params::version,
) inherits kibana4::params {

  class {'kibana4::user': }->
  class {'kibana4::install': }->
  class {'kibana4::service': }

}
