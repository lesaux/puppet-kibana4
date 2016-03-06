# == Class: kibana4
#
# Default parameters
#
class kibana4::params {
  $babel_cache_path              = '/tmp/babel.cache'
  $version                       = '4.3.1-linux-x64'
  $package_name                  = 'kibana'
  $install_method                = 'archive'
  $archive_dl_timeout            = 600
  $archive_provider              = 'camptocamp'
  $use_official_repo             = false
  $repo_version                  = '4.2'
  $service_ensure                = true
  $service_enable                = true
  $service_name                  = 'kibana4'
  $manage_init_file              = true
  $init_template                 = 'kibana4/kibana.init.erb'
  $manage_user                   = true
  $kibana4_group                 = 'kibana4'
  $kibana4_user                  = 'kibana4'
  $install_dir                   = '/opt'
  $symlink                       = true
  $symlink_name                  = "${install_dir}/kibana4"
  $es_download_site_url          = 'https://download.elastic.co'
  $config                        = undef
}
