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

* Downloads and extracts the kibana4 archive, or perform installation using OS package manager.
* Manage the elastic.co Kibana repositories
* Optionally create a user to use for the service. You should not create a user if installing Kibana with package management (apt or yum).
* Creates an init.d file if installing from the archive. Note that the init file is not managed if you are installing Kibana with package management (apt or yum).
* Modifies configuration file if needed.
* Java installation is not managed by this module.

### Beginning with kibana4

include kibana4

## Usage

If you decided to have the module create a user, you will need to specify
user name, group name, uid and gid.

### Example to install from archive

```puppet
  class { '::kibana4':
    package_ensure    => '4.3.0-linux-x64',
    package_provider  => 'archive',
    symlink           => true,
    manage_user       => true,
    kibana4_user      => kibana4,
    kibana4_group     => kibana4,
    kibana4_gid       => 200,
    kibana4_uid       => 200,
    config            => {
        'server.port'           => 5601,
        'server.host'           => '0.0.0.0',
        'elasticsearch.url'     => 'http://localhost:9200',
        }
  }
```

If you prefer to use "nanliu/archive" or "puppet/archive" as the archive
downloader instead of the default "camptocamp/archive" then set the class
parameter `archive_provider`. Make sure to have either "nanliu/archive" or
"puppet/archive" installed since dependency on one of multiple different
modules with the same name cannot be recorded in metadata.json (by default this
module uses and depends on "camptocamp/archive").

```puppet
  class { '::kibana4':
    package_ensure    => '4.1.1-linux-x64',
    package_provider  => 'archive',
    archive_provider  => 'nanliu', # or 'puppet'
    symlink           => false,
    manage_user       => true,
    kibana4_user      => kibana4,
    kibana4_group     => kibana4,
    kibana4_gid       => 200,
    kibana4_uid       => 200,
    config            => {
        'server.port'           => 5601,
        'server.host'           => '0.0.0.0',
        'elasticsearch.url'     => 'http://localhost:9200',
    }
  }
```

### Example to install from apt or yum repo

You will need to explicitly set the service_name to 'kibana' in most cases, because
for legacy reasons the default service_name is set to kibana4 - this may change in the future.
We disable user and init.d management as these are provided in official packages.
Notice how the config hash is different in version 4.1 than it is in version 4.3.

```puppet
class { '::kibana4':
  package_provider   => 'package',
  package_name       => 'kibana',
  package_ensure     => '4.1.1',
  manage_user        => false,
  manage_init_file   => false,
  service_name       => 'kibana',
  kibana4_user       => 'kibana',
  kibana4_group      => 'kibana',
  use_official_repo  => true,
  repo_version       => '4.1'
  config             => {
    'port'                 => 5601,
    'host'                 => '0.0.0.0',
    'elasticsearch_url'    => 'http://localhost:9200',
  }
}
```

## Parameters

Check all parameters in init.pp file

### Installation Parameters

[*package_ensure*]

Version of Kibana4 that gets installed.  Defaults to the latest 4.1.1 version
available at the time of module release.

[*package_name*]

The name of the Kibana4 package that gets installed. Defaults to 'kibana'.

[*package_provider*]

Set to 'archive' to download Kibana from the Elasticsearch download site (see
also `package_download_url` below).  Set to 'package' to use the default package
manager for installation.  Defaults to 'archive'.

[*archive_provider*]

Select which `archive` type should be used to download Kibana from the
Elasticsearch download site. There exist at least two modules that provide an
`archive` type: "camptocamp/archive" and "nanliu/archive" (or "puppet/archive"
since the module is now in the care of puppet-community). Defaults to
'camptocamp'. If you set this to 'nanliu' (or 'puppet') make sure you have that
module installed since both cannot be recorded as a dependency in metadata.json
at the same time.

[*package_download_url*]

Alternative URL from which to download Kibana if `package_provider` is
'archive'. Defaults to `undef`, because by default the URL is constructed
from the usual Elasticsearch download site URL, the `package_name` and
`package_ensure`.

[*package_proxy_server*]

Specify a proxy server if you need to use one. Defaults to `undef`.

[*use_official_repo*]
Use official apt or yum repository. Only used if package_provider is set to 'package'.

[*repo_version*]
Apt or yum repository version. Only used if 'use_official_repo' is set to 'true'.
defaults to '4.1'.

[*service_ensure*]

Specifies the service state. Valid values are stopped (false) and running
(true). Defaults to 'running'.

[*service_enable*]

Should the service be enabled on boot. Valid values are true, false, and
manual. Defaults to 'true'.

[*service_name*]

Name of the Kibana4 service. Defaults to 'kibana4'.

[*manage_init_file*]

Install init file. If the init script is provided by a package,
set it to `false`. Defaults to 'true'

[*init_template*]

Service file as a template. Defaults to 'kibana4/kibana.init'.

[*install_dir*]

Installation directory used if install_method is 'archive'
Defaults to '/opt'.

[*config_file*]
The location, as a path, of the Kibana configuration file.

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

 See Kibana4 documentation for a list of kibana server properties:
 https://www.elastic.co/guide/en/kibana/current/kibana-server-properties.html
 If you do not specify a hash of configuration parameters, then the default kibana.yml provided
 by the archive or package will be left intact.

[*config*]

A hash of key/value server properties. A value for the pid file is defaulted to '/var/run/kibana.pid' if you don't define it.

for version 4.3 an extensive config could look like:
```
config => {
  'server.port'                         => 5601,
  'server.host'                         => '0.0.0.0',
  'elasticsearch.url'                   => 'http://localhost:9200',
  'elasticsearch.preserveHost'          => true,
  'elasticsearch.ssl.cert'              => '/path/to/your/cert',
  'elasticsearch.ssl.key'               => '/path/to/your/key',
  'elasticsearch.password'              => 'password',
  'elasticsearch.username'              => 'username',
  'elasticsearch.pingTimeout'           => 1500,
  'elasticsearch.startupTimeout'        => 5000,
  'kibana.index'                        => '.kibana',
  'kibana.defaultAppId'                 => 'discover',
  'logging.silent'                      => false,
  'logging.quiet'                       => false,
  'logging.verbose'                     => false,
  'logging.events'                      => "{ log: ['info', 'warning', 'error', 'fatal'], response: '*', error: '*' }",
  'elasticsearch.requestTimeout'        => 500000,
  'elasticsearch.shardTimeout'          => 0,
  'elasticsearch.ssl.verify'            => true,
  'elasticsearch.ssl.ca'                => '[/path/to/a/CA,path/to/anotherCA/]',
  'server.ssl.key'                      => '/path/to/your/ssl/key',
  'server.ssl.cert'                     => '/path/to/your/ssl/cert',
  'pid.file'                            => '/var/run/kibana.pid',
  'logging.dest'                        => '/var/log/kibana/kibana.log',
}
```

## Reference

This module uses camptocamp/archives to download and extract the Kibana4 archive.

## Testing

### Rspec

You can install gem dependencies with
```
bundle install
```
and run tests with
```
bundle exec rake spec
```

### Beaker-rspec

You can run beaker-spec tests which will start two vagrant boxes, one to do basic test of the `archive` installation method, and the other
to test the `package` installation method. Each vagrant box also runs elasticsearch.
At this time these tests are fairly basic. We use a basic manifest in each case and ensure that the puppet return code is 2 (the run succeeded,
and some resources were changed) on the first run, and ensure that the return code is 0 (the run succeeded with no changes or failures; 
the system was already in the desired state) on the second run.
Available node sets are centos-66-x64, centos-70-x64, ubuntu-1204-x64, ubuntu-1404-x64, debian-78-x64.
Run with:
```
BEAKER_set=centos-66-x64 bundle exec rspec spec/acceptance
```
