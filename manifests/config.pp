class kibana4::config {

  file {"${kibana4::install_dir}/kibana-${kibana4::version}/config/kibana.yml":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    content => template("kibana4/kibana.yml.erb"),
    notify  => Service['kibana4'],
  }  

}
