# == Class: kibana4
#
# Installation
#
class kibana4::install {

  contain kibana4::install::package

	file { 'kibana_plugin_install_proxy.sh': 
	  ensure  => 'file', 
	  path    => '/opt/kibana/kibana_plugin_install_proxy.sh', 
	  mode    => '0755', 
	  source  => 'puppet:///modules/kibana4/kibana_plugin_install_proxy.sh', 
    require => Class['kibana4::install::package'], 
	}

}
