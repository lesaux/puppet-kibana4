# kibana4

[![Puppet Forge](http://img.shields.io/puppetforge/v/lesaux/kibana4.svg)](https://forge.puppetlabs.com/lesaux/kibana4)
[![Build Status](http://img.shields.io/travis/lesaux/puppet-kibana4.svg)](http://travis-ci.org/lesaux/puppet-kibana4)


#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with kibana4](#setup)
    * [What kibana4 affects](#what-kibana4-affects)
    * [Beginning with kibana4](#beginning-with-kibana4)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Parameters](#parameters)
6. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
7. [Limitations - OS compatibility, etc.](#limitations)

## Overview

Install and configure Kibana4. Should work on any linux OS.

## Module Description

This module assumes you have a working Elasticsearch installation and indices (usually an "ELK" stack).
Kibana4 only works with recent versions of Elasticsearch (1.4.4 and later). I recommend using the "elasticsearch" output with `protocol => "http"` in Logstash (supported since 1.4.0) as the default `protocol => "node"` uses ES version 1.1.1 and will prevent Kibana4 from connecting.

## Setup

### What kibana4 affects

* Downloads and extracts the kibana4 archive
* Optionally create a user to use for the service
* Creates an init.d file as one is not yet provided by the archive
* Modifies configuration file if needed.
* Java installation is not managed by this module.

### Beginning with kibana4

include kibana4

## Usage

If you decided to have the module create a user, you will need to specify
user name, group name, uid and gid.

```
  class { '::kibana4':
    package_ensure    => '4.0.0-linux-x64',
    package_provider  => 'archive',
    symlink           => false,
    manage_user       => true,
    kibana4_user      => kibana4,
    kibana4_group     => kibana4,
    kibana4_gid       => 200,
    kibana4_uid       => 200,
    elasticsearch_url => 'http://localhost:9200',
  }
```

## Parameters

Check all parameters in init.pp file

### Installation Parameters

[*package_ensure*]

Version of Kibana4 that gets installed.  Defaults to the latest 4.0.0 version
available at the time of module release.

[*package_name*]

The name of the Kibana4 package that gets installed. Defaults to 'kibana'.

[*package_provider*]

Set to 'archive' to download Kibana from the Elasticsearch download site (see
also `package_download_url` below).  Set to 'package' to use the default package
manager for installation.  Defaults to 'archive'.

[*package_download_url*]

Alternative URL from which to download Kibana if `package_provider` is
'archive'. Defaults to `undef`, because by default the URL is constructed
from the usual Elasticsearch download site URL, the `package_name` and
`package_ensure`.

[*service_ensure*]

Specifies the service state. Valid values are stopped (false) and running
(true). Defaults to 'running'.

[*service_enable*]

Should the service be enabled on boot. Valid values are true, false, and
manual. Defaults to 'true'.

[*service_name*]

Name of the Kibana4 service. Defaults to 'kibana4'.

[*install_dir*]

Installation directory used iff install_method is 'archive'
Defaults to '/opt'.

[*symlink*]

Determines if a symlink should be created in the installation directory for
the extracted archive. Only used if install_method is 'archive'.
Defaults to 'true'.

[*symlink_name*]

Sets the name to be used for the symlink. The default is '$install_dir/kibana4'.
Only used if `package_provider` is 'archive'.

[*manage_user*]

Should the user and group that will run the Kibana service be created and managed by
Puppet? Defaults to 'true'.

[*kibana4_user*]

The user that will run the service. For now installation directory is still owned by root.

[*kibana4_uid*]

The user ID assigned to the user specified in `kibana4_user`. Defaults to `undef`.

[*kibana4_group*]

The primary group of the kibana user

[*kibana4_gid*]

The group ID assigned to the group specified in `kibana4_group`. Defaults to `undef`.

### Configuration Parameters

 See Kibana4 documentation for more details. Defaults values are the same as defaults from kibana.yml
 provided in the archive version 4.0.0-linux-x64.

 [*port*]

 [*host*]

 [*elasticsearch_url*]

 [*elasticsearch_preserve_host*]

 [*kibana_index*]

 [*default_app_id*]

 [*request_timeout*]

 [*shard_timeout*]

 [*verify_ssl*]

Default has been changed to false.
Providing better SSL support is my todo list.

 [*ca*]

 [*ssl_key_file*]

 [*ssl_cert_file*]

 [*pid_file*]

 [*bundled_plugin_ids*]


## Reference

This module uses camptocamp/archives to download and extract the Kibana4 archive.

## Limitations

Basic spec testing is done, but no tests on the generated config file are done at the moment.

