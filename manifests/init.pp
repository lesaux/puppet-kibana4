# == Class: Kibana4
#
# Installs and configures Kibana4.
#
# === Parameters
#
# [*version*]
# Version of Kibana4 that gets installed.  Defaults to the latest 4.0.0 version
# available at the time of module release.
#
# [*package_name*]
# The name of the Kibana4 package that gets installed. Defaults to 'kibana'.
#
# [*install_method*]
# Set to 'archive' to download Kibana from the Elasticsearch download site (see
# also `archive_download_url` below).  Set to 'package' to use the default package
# manager for installation.  Defaults to 'archive'.
#
# [*archive_provider*]
# Select which `archive` type should be used to download Kibana from the
# Elasticsearch download site. There exist at least two modules that provide an
# `archive` type: "camptocamp/archive" and "nanliu/archive" (or "puppet/archive"
# since the module is now in the care of puppet-community). Defaults to
# 'camptocamp'. If you set this to 'nanliu' (or 'puppet') make sure you have that
# module installed since both cannot be recorded as a dependency in metadata.json
# at the same time.
#
# [*archive_download_url*]
# Alternative URL from which to download Kibana if `install_method` is
# 'archive'. Defaults to `undef`, because by default the URL is constructed
# from the usual Elasticsearch download site URL, the `package_name` and
# `version`.
#
# [*archive_dl_timeout*]
# Specifies a package download timeout, used only if `archive_provider` is set to
# 'camptocamp'.  Default is 600.
#
# [*package_proxy_server*]
# Specifies which proxy server use to download archive. Valid format is
# http[s]//[user:passwd@]proxy_host:port. Not supported when `archive_provider`
# is 'nanliu' or 'puppet'.
#
# [*package_use_official_repo*]
# Use official apt or yum repository. Only used if install_method is set to 'package'.
#
# [*package_repo_version*]
# apt or yum repository version. Only used if 'package_use_official_repo' is set to 'true'.
# defaults to '4.1'.
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
# [*init_template*]
# Service file as a template
#
# [*manage_init_file*]
# Install init file. If the init script is provided by a package,
# set it to `false`. Defaults to 'true'
#
# [*install_dir*]
# Installation directory used iff install_method is 'archive'
# Defaults to '/opt'.
#
# [*config_file*]
# The location, as a path, of the Kibana configuration file.
#
# [*symlink*]
# Determines if a symlink should be created in the installation directory for
# the extracted archive. Only used if install_method is 'archive'.
# Defaults to 'true'.
#
# [*symlink_name*]
# Sets the name to be used for the symlink. The default is '$install_dir/kibana4'.
# Only used if `install_method` is 'archive'.
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
# [*babel_cache_path*]
# Kibana uses babel (https://www.npmjs.com/package/babel) which writes it's cache to this location
#
# === Examples
#
#   see README file
#
class kibana4 (
  $version                       = $kibana4::params::version,
  $package_name                  = $kibana4::params::package_name,
  $install_method                = $kibana4::params::install_method,
  $archive_download_url          = undef,
  $archive_dl_timeout            = $kibana4::params::archive_dl_timeout,
  $package_proxy_server          = undef,
  $archive_provider              = $kibana4::params::archive_provider,
  $package_use_official_repo             = $kibana4::params::package_use_official_repo,
  $package_repo_version                  = $kibana4::params::package_repo_version,
  $service_ensure                = $kibana4::params::service_ensure,
  $service_enable                = $kibana4::params::service_enable,
  $service_name                  = $kibana4::params::service_name,
  $manage_init_file              = $kibana4::params::manage_init_file,
  $init_template                 = $kibana4::params::init_template,
  $manage_user                   = $kibana4::params::manage_user,
  $kibana4_group                 = $kibana4::params::kibana4_group,
  $kibana4_gid                   = undef,
  $kibana4_user                  = $kibana4::params::kibana4_user,
  $kibana4_uid                   = undef,
  $install_dir                   = $kibana4::params::install_dir,
  $config_file                   = undef,
  $symlink                       = $kibana4::params::symlink,
  $symlink_name                  = $kibana4::params::symlink_name,
  $config                        = $kibana4::params::config,
) inherits kibana4::params {

  class {'kibana4::user': }->
  class {'kibana4::install': }->
  class {'kibana4::config': }->
  class {'kibana4::service': }

}
