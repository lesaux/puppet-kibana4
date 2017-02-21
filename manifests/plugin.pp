# == Define: kibana::plugin
#
# This define allows you to install arbitrary Kibana plugins
# either by using the default repositories or by specifying an URL
#
# All default values are defined in the kibana::params class.
#
#
# === Parameters
#
# [*kibana_plugin_dir*]
#   Directory where all modules will be installed
#   Default to '/usr/share/kibana/installedPlugins'
#
# [*plugin_dest_dir*]
#   Directory where the module will be installed
#   This parameter is mandatory.
#   For example 'sense' or 'marvel'
#
# [*ensure*]
#   Whether the plugin will be installed or removed.
#   Set to 'absent' to ensure a plugin is not installed
#
# [*url*]
#   Specify an URL where to download the plugin from.
#   This variable is optional
#

define kibana::plugin(
  $ensure = 'present',
  $url    = undef,
) {

  if $url {
    $plugin = $url
  } else {
    $plugin = $name
  }

  validate_re($ensure, ['absent', 'present'])
  validate_string($plugin)

  $plugin_dir = "${kibana::package_install_dir}/plugins"
  $plugin_exe = "${kibana::package_install_dir}/bin/kibana-plugin"

  case $ensure {
    'present': {
      exec { "install_kibana_plugin_${name}":
        command => "${plugin_exe} install --quiet --plugin-dir ${plugin_dir} ${plugin}",
        unless  => "${plugin_exe} list --plugin-dir ${plugin_dir} | grep --fixed-strings --quiet '${plugin}'",
        notify  => Service['kibana'],
        require => Class['kibana::install'],
      }
    }

    'absent': {
      exec { "remove_kibana_plugin_${name}":
        command => "${plugin_exe} remove --quiet --plugin-dir ${plugin_dir} ${plugin}",
        onlyif  => "${plugin_exe} list --plugin-dir ${plugin_dir} | grep --fixed-strings --quiet '${plugin}'",
        notify  => Service['kibana'],
        require => Class['kibana::install'],
      }
    }
  }

}
