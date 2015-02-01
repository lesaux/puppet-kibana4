# == Class: kibana4
#
# Default parameters
#
class kibana4::params {

  $default_route      = '/dashboard/file/default.json'
  $kibana_group      = 'root'
  $kibana_user       = 'root'
  $install_dir        = '/opt'
  $install_method     = 'archive'
  $symlink            = true
  $version            = '4.0.0-beta3'
}

