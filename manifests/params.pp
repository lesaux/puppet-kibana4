# == Class: kibana4
#
# Default parameters
#
class kibana4::params {
  $ensure            = false
  $enable            = false
  $create_user       = false
  $kibana4_group     = 'root'
  $kibana4_gid       = undef
  $kibana4_user      = 'root'
  $kibana4_uid       = undef
  $install_dir       = '/opt'
  $install_method    = 'archive'
  $symlink           = true
  $version           = '4.0.0-linux-x64'
}

