# == Class: kibana4
#
# Default parameters
#
class kibana4::params {
  $ensure                      = true
  $enable                      = true
  $create_user                 = false
  $kibana4_group               = 'root'
  $kibana4_gid                 = undef
  $kibana4_user                = 'root'
  $kibana4_uid                 = undef
  $install_dir                 = '/opt'
  $install_method              = 'archive'
  $symlink                     = true
  $version                     = '4.0.0-linux-x64'
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

