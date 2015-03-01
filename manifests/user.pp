# == Class: kibana4
#
# User creation
#
class kibana4::user {

  if $kibana4::manage_user {

    group { $kibana4::kibana4_group:
      ensure => present,
      system => true,
      gid    => $kibana4::kibana4_gid,
    }

    user { $kibana4::kibana4_user:
      ensure     => present,
      comment    => 'Kibana4 System Account',
      gid        => $kibana4::kibana4_gid,
      home       => '/bin/false',
      managehome => false,
      shell      => '/bin/false',
      system     => true,
      uid        => $kibana4::kibana4_uid,
    }

  }

}

