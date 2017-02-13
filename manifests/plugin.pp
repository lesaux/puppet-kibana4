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
  $plugin_dest_dir        = undef,
  $kibana_plugin_dir     = '/usr/share/kibana/plugins',
  $ensure                 = 'present',
  $url                    = undef,
) {

  if !$plugin_dest_dir {
    fail('you must define a plugin destination dir, such as `marvel`')
  }

  if $url {
      $plugin_name =  $url
  } else {
      $plugin_name = $name
  }

  case $ensure {

    'present': {

        exec { "install_kibana_plugin_${name}":
        command => "/usr/share/kibana/bin/kibana-plugin install ${plugin_name} -d ${kibana_plugin_dir}",
        path    => '/usr/share/kibana/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
        unless  => "test -d ${kibana_plugin_dir}/${plugin_dest_dir}",
        notify  => Service['kibana'],
        }

    }

    'absent': {
        exec { "remove_kibana_plugin_${name}":
        command => "rm -rf ${kibana_plugin_dir}/${plugin_dest_dir}",
        path    => '/usr/share/kibana/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
        unless  => "test ! -d ${kibana_plugin_dir}/${plugin_dest_dir}",
        notify  => Service['kibana'],
        }

    }

    default: {
      fail('`ensure` should be either `present` or `absent`')
    }

  }

}
