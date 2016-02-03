# == Class: kibana4
#
# Service creation and mgmt
#
class kibana4::service {

  # init file from template
  if ($kibana4::manage_init_file == true) {
    file { "/etc/init.d/${kibana4::service_name}":
      ensure  => present,
      mode    => '0755',
      content => template($kibana4::init_template),
      group   => root,
      owner   => root,
    }

    file { '/etc/default/kibana4':
      ensure  => file,
      mode    => '0644',
      content => template('kibana4/default.erb'),
      group   => root,
      owner   => root,
    }

    $require = [File["/etc/init.d/${kibana4::service_name}"], File['/etc/default/kibana4']]

  }

  if $kibana4::use_systemd {

    file { "/etc/systemd/system/${kibana4::service_name}.service":
      content => template('kibana4/kibana.systemd.erb'),
      mode    => '0755',
    }
    ~>
    exec { 'execute kibana-service reload':
      command       => '/bin/systemctl daemon-reload',
      refreshonly   => true,
    }

    file { "/etc/init.d/${kibana4::service_name}":
      ensure  => absent,
    }

    $require = File["/etc/systemd/system/${kibana4::service_name}.service"]

  }

  service { 'kibana4':
    ensure     => $kibana4::service_ensure,
    enable     => $kibana4::service_enable,
    name       => $kibana4::service_name,
    hasstatus  => true,
    hasrestart => true,
    require    => $require
  }

}
