# == Class: Kibana
#
# Installs and configures Kibana.
#
# === Parameters
#
# [*version*]
# Version of Kibana that gets installed.  Defaults to the latest version
# available in the `package_repo_version` that is selected.
#
# [*manage_repo*]
# Enable repo management by enabling the official repositories.
#
# [*package_repo_version*]
# apt or yum repository version. Only used if 'package_use_official_repo' is set to 'true'.
# defaults to '4.5'.
#
# [*package_repo_proxy*]
# A proxy to use for downloading packages.
# Defaults to 'undef'. You can change this if you are behind a proxy
#
# [*service_ensure*]
# Specifies the service state. Valid values are stopped (false) and running
# (true). Defaults to 'running'.
#
# [*service_enable*]
# Should the service be enabled on boot. Valid values are true, false, and
# manual. Defaults to 'true'.
#
# [*service_name*]
# Name of the Kibana service. Defaults to 'kibana'.
#
# [*babel_cache_path*]
# Kibana uses babel (https://www.npmjs.com/package/babel) which writes it's cache to this location
#
# === Examples
#
#   see README file
#
class kibana (
  $version                       = $kibana::params::version,
  $manage_repo                   = $kibana::params::manage_repo,
  $package_repo_version          = $kibana::params::package_repo_version,
  $package_repo_proxy            = undef,
  $service_ensure                = $kibana::params::service_ensure,
  $service_enable                = $kibana::params::service_enable,
  $service_name                  = $kibana::params::service_name,
  $service_provider              = $kibana::params::service_provider,
  $config                        = $kibana::params::config,
  $plugins                       = undef,
) inherits kibana::params {

  validate_bool($manage_repo)

  if ($manage_repo) {
    validate_string($package_repo_version)
  }

  class {'kibana::install': }->
  class {'kibana::config': }->
  class {'kibana::service': }

  Kibana::Plugin { require => Class['kibana::install'] }

  if $plugins {
    validate_hash($plugins)
    create_resources('kibana::plugin', $plugins)
  }
}
