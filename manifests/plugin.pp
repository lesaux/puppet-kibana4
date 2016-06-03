# == Define: kibana4::plugin
#
# This define allows you to install arbitrary Kibana plugins
# either by using the default repositories or by specifying an URL
#
# All default values are defined in the kibana4::params class.
#
#
# === Parameters
#
# [*kibana4_plugin_dir*]
#   Directory where all modules will be installed
#   Default to '/opt/kibana/installedPlugins'
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

define kibana4::plugin(
  $plugin_dest_dir        = undef,
  $kibana4_plugin_dir     = '/opt/kibana/installedPlugins',
  $ensure                 = 'present',
  $url                    = undef,
) {

  if !$plugin_dest_dir {
    fail('you must define a plugin destination dir, such as `marvel`')
  }

  case $ensure {

    'present': {

      if !$url {

        exec { "install_kibana_plugin_${name}":
        command => "/opt/kibana/bin/kibana plugin --install ${name} -d ${kibana4_plugin_dir && service kibana restart}",
        path    => '/opt/kibana:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
        unless  => "test -d ${kibana4_plugin_dir}/${plugin_dest_dir}",
        }

      } else {

        exec { "install_kibana_plugin_${name}":
        command => "/opt/kibana/bin/kibana plugin --install ${name} -u ${url} -d ${kibana4_plugin_dir} && service kibana restart",
        path    => '/opt/kibana:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
        unless  => "test -d ${kibana4_plugin_dir}/${plugin_dest_dir}",
        }

      }
      #Kibana needs to be running before installing any plugin
      Service['kibana4'] -> Exec["install_kibana_plugin_${name}"]
    }

    'absent': {
        exec { "remove_kibana_plugin_${name}":
        command => "rm -rf ${kibana4_plugin_dir}/${plugin_dest_dir}  && service kibana restart",
        path    => '/opt/kibana:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
        unless  => "test ! -d ${kibana4_plugin_dir}/${plugin_dest_dir}",
        }
        Service['kibana4'] -> Exec["remove_kibana_plugin_${name}"]
    }

    default: {
      fail('`ensure` should be either `present` or `absent`')
    }

  }

}
