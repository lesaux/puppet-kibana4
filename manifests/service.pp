# == Class: kibana
#
# Service creation and mgmt
#
class kibana::service {

  service { 'kibana':
    ensure     => $kibana::service_ensure,
    enable     => $kibana::service_enable,
    provider   => $kibana::service_provider,
    hasstatus  => true,
    hasrestart => true,
  }

}
