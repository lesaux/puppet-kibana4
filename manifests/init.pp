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
# apt or yum repository version.
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
# === Examples
#
#   see README file
#
class kibana (
  $version                       = $kibana::params::version,
  $manage_repo                   = $kibana::params::manage_repo,
  $package_repo_version          = undef,
  $package_repo_proxy            = undef,
  $service_ensure                = $kibana::params::service_ensure,
  $service_enable                = $kibana::params::service_enable,
  $service_provider              = $kibana::params::service_provider,
  $config                        = $kibana::params::config,
  $plugins                       = $kibana::params::plugins,
) inherits kibana::params {

  validate_bool($manage_repo)
  if ($manage_repo) {
    validate_re($package_repo_version, '^\d+\.\d+$')
  }
  validate_hash($config)
  validate_hash($plugins)

  if $package_repo_version == undef {
    $config_path = undef
    $package_install_dir = undef
  } elsif versioncmp($package_repo_version, '5.0') >= 0 {
    $config_path = '/etc/kibana/kibana.yml'
    $package_install_dir = '/usr/share/kibana'
  } else {
    $config_path = '/opt/kibana/config/kibana.yml'
    $package_install_dir = '/opt/kibana'
  }

  class { 'kibana::install': } ->
  class { 'kibana::config': } ->
  class { 'kibana::service': }

  create_resources('kibana::plugin', $plugins)
}
