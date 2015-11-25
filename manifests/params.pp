# == Class: kibana4
#
# Default parameters
#
class kibana4::params {
  $babel_cache_path            = '/tmp/babel.cache'
  $package_ensure                = '4.2.1-linux-x64'
  $package_name                  = 'kibana'
  $package_provider              = 'archive'
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
  $server_port                   = 5601
  $server_host                   = '0.0.0.0'
  $server_base_path              = ''
  $server_xsrf_token             = ''
  $kibana_index                  = '.kibana'
  $kibana_default_app_id         = 'discover'
  $elasticsearch_request_timeout = 500000
  $elasticsearch_shard_timeout   = 0
  $elasticsearch_ping_timeout    = 1500
  $elasticsearch_startup_timeout = 5000
  $elasticsearch_url             = 'http://localhost:9200'
  $elasticsearch_preserve_host   = true
  $elasticsearch_ssl_verify      = false
  $logging_dest                  = '/var/log/kibana/kibana4.log'
  $logging_silent                = false
  $logging_quiet                 = false
  $logging_verbose               = false
  $logging_events                = {}
  $pid_file                      = '/var/run/kibana.pid'
  $es_download_site_url          = 'https://download.elasticsearch.org'
}