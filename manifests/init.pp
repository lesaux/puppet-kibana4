# == Class: Kibana4
#
# Installs and configures Kibana4.
#
# === Parameters
#
# [*package_ensure*]
# Version of Kibana4 that gets installed.  Defaults to the latest 4.0.0 version
# available at the time of module release.
#
# [*package_name*]
# The name of the Kibana4 package that gets installed. Defaults to 'kibana'.
#
# [*package_provider*]
# Set to 'archive' to download Kibana from the Elasticsearch download site (see
# also `package_download_url` below).  Set to 'package' to use the default package
# manager for installation.  Defaults to 'archive'.
#
# [*package_download_url*]
# Alternative URL from which to download Kibana iff `package_provider` is
# 'archive'. Defaults to `undef`, because by default the URL is constructed
# from the usual Elasticsearch download site URL, the `package_name` and
# `package_ensure`.
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
# Name of the Kibana4 service. Defaults to 'kibana4'.
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
# Sets the name to be used for the symlink. The default is '$install_dir/kibana4'.
# Only used if `package_provider` is 'archive'.
#
# [*manage_user*]
# Should the user that will run the Kibana service be created and managed by
# Puppet? Defaults to 'false'.
#
# [*kibana4_user*]
# The user that will run the service. For now installation directory is still owned by root.
#
# [*kibana4_uid*]
# The user ID assigned to the user specified in `kibana4_user`. Defaults to `undef`.
#
# [*kibana4_group*]
# The primary group of the kibana user
#
# [*kibana4_gid*]
# The group ID assigned to the group specified in `kibana4_group`. Defaults to `undef`.
#
# === Examples
#
#  class { '::kibana4':
#    package_ensure => '4.0.0',
#    install_method => 'package',
#  }
#
class kibana4 (
  $package_ensure              = $kibana4::params::package_ensure,
  $package_name                = $kibana4::params::package_name,
  $package_provider            = $kibana4::params::package_provider,
  $package_download_url        = $kibana4::params::package_download_url,
  $service_ensure              = $kibana4::params::service_ensure,
  $service_enable              = $kibana4::params::service_enable,
  $service_name                = $kibana4::params::service_name,
  $manage_user                 = $kibana4::params::manage_user,
  $kibana4_group               = $kibana4::params::kibana4_group,
  $kibana4_gid                 = $kibana4::params::kibana4_gid,
  $kibana4_user                = $kibana4::params::kibana4_user,
  $kibana4_uid                 = $kibana4::params::kibana4_uid,
  $install_dir                 = $kibana4::params::install_dir,
  $symlink                     = $kibana4::params::symlink,
  $symlink_name                = $kibana4::params::symlink_name,
  $port                        = $kibana4::params::port,
  $host                        = $kibana4::params::host,
  $elasticsearch_url           = $kibana4::params::elasticsearch_url,
  $elasticsearch_preserve_host = $kibana4::params::elasticsearch_preserve_host,
  $kibana_index                = $kibana4::params::kibana_index,
  $default_app_id              = $kibana4::params::default_app_id,
  $request_timeout             = $kibana4::params::request_timeout,
  $shard_timeout               = $kibana4::params::shard_timeout,
  $verify_ssl                  = $kibana4::params::verify_ssl,
  $ca                          = $kibana4::params::ca,
  $ssl_key_file                = $kibana4::params::ssl_key_file,
  $ssl_cert_file               = $kibana4::params::ssl_cert_file,
  $pid_file                    = $kibana4::params::pid_file,
  $bundled_plugin_ids          = $kibana4::params::bundled_plugin_ids,
) inherits kibana4::params {

  class {'kibana4::user': }->
  class {'kibana4::install': }->
  class {'kibana4::config': }->
  class {'kibana4::service': }

}
