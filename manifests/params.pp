# == Class: kibana4
#
# Default parameters
#
class kibana4::params {
  $kibana_group      = 'root'
  $kibana_user       = 'root'
  $install_dir        = '/opt'
  $install_method     = 'archive'
  $symlink            = true
  $version            = '4.0.0-linux-x64'
}

