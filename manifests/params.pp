# == Class: kibana4
#
# Default parameters
#
class kibana4::params {
  $package_ensure              = '4.0.0-linux-x64'
  $package_name                = 'kibana'
  $package_provider            = 'archive'
  $package_download_url        = undef
  $es_download_site_url        = 'https://download.elasticsearch.org'
  $service_ensure              = true
  $service_enable              = true
  $service_name                = 'kibana4'
  $manage_user                 = true
  $kibana4_group               = 'kibana4'
  $kibana4_gid                 = undef
  $kibana4_user                = 'kibana4'
  $kibana4_uid                 = undef
  $install_dir                 = '/opt'
  $symlink                     = true
  $symlink_name                = "${install_dir}/kibana4"
  $port                        = '5601'
  $host                        = '0.0.0.0'
  $elasticsearch_url           = 'http://localhost:9200'
  $elasticsearch_preserve_host = true
  $kibana_index                = '.kibana'
  $default_app_id              = 'discover'
  $request_timeout             = '300000'
  $shard_timeout               = '0'
  $verify_ssl                  = false
  $ca                          = '/path/to/your/CA.pem'
  $ssl_key_file                = '/path/to/your/server.key'
  $ssl_cert_file               = '/path/to/your/server.crt'
  $pid_file                    = '/var/run/kibana.pid'
  $bundled_plugin_ids          = [
    'plugins/dashboard/index','plugins/discover/index',
    'plugins/doc/index','plugins/kibana/index',
    'plugins/markdown_vis/index','plugins/metric_vis/index',
    'plugins/settings/index','plugins/table_vis/index',
    'plugins/vis_types/index','plugins/visualize/index' ]
}

