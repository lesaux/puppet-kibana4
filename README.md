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

This module assumes you have a working Elasticsearch installation and indices (usually an 'ELK' stack).  Kibana4 only works with recent versions of Elasticsearch (1.4.4 and later).  I recommend using the 'elasticsearch' output with `protocol => 'http'` in Logstash (supported since 1.4.0) as the default `protocol => 'node'` uses ES version 1.1.1 and will prevent Kibana4 from connecting.

## Setup

### What kibana4 affects

* Downloads and extracts the kibana4 archive, or perform installation using OS package manager.
* Manage the elastic.co Kibana repositories
* Optionally create a user to use for the service. You should not create a user if installing Kibana with package management (apt or yum).
* Creates an init.d file if installing from the archive. Note that the init file is not managed if you are installing Kibana with package management (apt or yum).
* Modifies configuration file if needed.
* Java installation is not managed by this module.

### Beginning with kibana4

```puppet
include kibana4
```

## Usage

### Example to install from apt or yum repo

The elastic.co packages create a kibana user and group (999:999) and they provide an init file `/etc/init.d/kibana`.  This is now the preferred installation method for kibana4.

```puppet
include kibana4
```

### Example to install from archive

If you decide to have the module create a user, you will need to specify user name, group name, uid and gid.

```puppet
  class { 'kibana4':
    version         => '4.4.1-linux-x64',
    install_method  => 'archive',
    archive_symlink => true,
    manage_user     => true,
    kibana4_user    => 'kibana4',
    kibana4_group   => 'kibana4',
    kibana4_gid     => 3000,
    kibana4_uid     => 3000,
    config          => {
      'server.port'       => 5601,
      'server.host'       => '0.0.0.0',
      'elasticsearch.url' => 'http://localhost:9200',
    },
  }
```

If you prefer to use [nanliu/archive](https://forge.puppet.com/nanliu/archive) or [puppet/archive](https://forge.puppet.com/puppet/archive) as the archive downloader instead of the default [camptocamp/archive](https://forge.puppet.com/camptocamp/archive) then set the class parameter `archive_provider`. Make sure to have either nanliu/archive or puppet/archive installed since dependency on one of multiple different modules with the same name cannot be recorded in `metadata.json` (by default this module uses and depends on camptocamp/archive).

```puppet
  class { 'kibana4':
    version          => '4.4.1-linux-x64',
    install_method   => 'archive',
    archive_provider => 'nanliu', # or 'puppet'
    archive_symlink  => false,
    manage_user      => true,
    kibana4_user     => 'kibana4',
    kibana4_group    => 'kibana4',
    kibana4_gid      => 200,
    kibana4_uid      => 200,
    config           => {
      'server.port'       => 5601,
      'server.host'       => '0.0.0.0',
      'elasticsearch.url' => 'http://localhost:9200',
    },
  }
```

## Parameters

Check all parameters in the `manifests/init.pp` file.

### Installation Parameters

#### `version`

Version of Kibana4 that gets installed.  Defaults to the latest 4.1.1 version available at the time of module release.

#### `package_name`

The name of the Kibana4 package that gets installed. Defaults to 'kibana'.

#### `install_method`

Set to 'archive' to download Kibana from the Elasticsearch download site (see also `archive_download_url` below).  Set to 'package' to use the default package manager for installation.  Defaults to 'package'.

#### `archive_provider`

Select which `archive` type should be used to download Kibana from the Elasticsearch download site. There exist at least two modules that provide an `archive` type: 'camptocamp/archive' and 'nanliu/archive' (or 'puppet/archive' since the module is now in the care of puppet-community). Defaults to 'camptocamp'. If you set this to 'nanliu' (or 'puppet') make sure you have that module installed since both cannot be recorded as a dependency in metadata.json at the same time.

#### `archive_download_url`

Alternative URL from which to download Kibana if `install_method` is 'archive'. Defaults to `undef`, because by default the URL is constructed from the usual Elasticsearch download site URL, the `package_name` and `version`.

#### `archive_proxy_server`

Specify a proxy server if you need to use one. Defaults to `undef`.

#### `package_use_official_repo`

Use official apt or yum repository. Only used if install_method is set to 'package'.

#### `package_repo_version`

Apt or yum repository version. Only used if 'package_use_official_repo' is set to 'true'.  Defaults to '4.1'.

#### `package_repo_proxy`

Whether or not to use a proxy for downloading the kibana4 package. Default is 'undef, so no proxy will be used.

#### `service_ensure`

Specifies the service state. Valid values are stopped (false) and running (true).  Defaults to 'running'.

#### `service_enable`

Should the service be enabled on boot. Valid values are 'true', 'false', and 'manual'.  Defaults to 'true'.

#### `service_name`

Name of the Kibana4 service. Defaults to 'kibana'.

#### `manage_init_file`

Install init file. If the init script is provided by a package, set it to `false`. Defaults to 'true'.

#### `init_template`

Service file as a template. Defaults to 'kibana4/kibana.init'.

#### `archive_install_dir`

Installation directory used if install_method is 'archive'.  Defaults to '/opt'.

#### `config_file`

The location, as a path, of the Kibana configuration file.

#### `archive_symlink`

Determines if a symlink should be created in the installation directory for the extracted archive. Only used if install_method is 'archive'.  Defaults to 'true'.

#### `archive_symlink_name`

Sets the name to be used for the symlink. The default is '$archive_install_dir/kibana'.  Only used if `install_method` is 'archive'.

#### `manage_user`

Specifies whether the user and group that will run the Kibana service is to be created and managed by Puppet.  Defaults to 'true'.

#### `kibana4_user`

The user that will run the service. Defaults to 'kibana'.

#### `kibana4_uid`

The user ID assigned to the user specified in `kibana4_user`. Defaults to `undef`.

#### `kibana4_group`

The primary group of the kibana user. Defaults to 'kibana'.

#### `kibana4_gid`

The group ID assigned to the group specified in `kibana4_group`. Defaults to `undef`.

#### `plugins`

Simple plugin support has been added, but updating existing plugins is not yet supported.  A hash of plugins and their installation parameters is expected:

```puppet
class { 'kibana4':
  ...
  plugins => {
    'elasticsearch/marvel' => {
       kibana4_plugin_dir => '/opt/kibana/installedPlugins', # optional - this is the default
       plugin_dest_dir    => 'marvel',                       # mandatory - plugin will be installed in ${kibana4_plugin_dir}/${plugin_dest_dir}
       url                => 'http://your_custom_url',       # necessary if using arbitrary URL
       ensure             => present,                        # mandatory - either 'present' or 'absent'
    },
    'elastic/sense' => {
       ensure          => present,
       plugin_dest_dir => 'sense',
    },
  }
}
```

### Configuration Parameters

* See the [Kibana4 documentation](https://www.elastic.co/guide/en/kibana/current/kibana-server-properties.html) for a full list of kibana server properties.
* Note: If you do not specify a hash of configuration parameters, then the default `kibana.yml` provided by the archive or package will be left intact.
* Note: The config hash is different in version 4.1 than it is in version 4.3.

#### `config`

A hash of key/value server properties. Note that the default value for `pid.file` in the Kibana 4 application is `/var/run/kibana.pid`.

For version 4.3 an extensive config could look like:

```puppet
  ...
  config => {
    'server.port'                  => 5601,
    'server.host'                  => '0.0.0.0',
    'elasticsearch.url'            => 'http://localhost:9200',
    'elasticsearch.preserveHost'   => true,
    'elasticsearch.ssl.cert'       => '/path/to/your/cert',
    'elasticsearch.ssl.key'        => '/path/to/your/key',
    'elasticsearch.password'       => 'password',
    'elasticsearch.username'       => 'username',
    'elasticsearch.pingTimeout'    => 1500,
    'elasticsearch.startupTimeout' => 5000,
    'kibana.index'                 => '.kibana',
    'kibana.defaultAppId'          => 'discover',
    'logging.silent'               => false,
    'logging.quiet'                => false,
    'logging.verbose'              => false,
    'logging.events'               => "{ log: ['info', 'warning', 'error', 'fatal'], response: '*', error: '*' }",
    'elasticsearch.requestTimeout' => 500000,
    'elasticsearch.shardTimeout'   => 0,
    'elasticsearch.ssl.verify'     => true,
    'elasticsearch.ssl.ca'         => '[/path/to/a/CA,path/to/anotherCA/]',
    'server.ssl.key'               => '/path/to/your/ssl/key',
    'server.ssl.cert'              => '/path/to/your/ssl/cert',
    'pid.file'                     => '/var/run/kibana.pid',
    'logging.dest'                 => '/var/log/kibana/kibana.log',
  },
```

## Testing

### Rspec

You can install gem dependencies with
```
$ bundle install
```
and run tests with
```
$ bundle exec rake spec
```

### Beaker-rspec

You can run beaker-spec tests which will start two vagrant boxes, one to do basic test of the `archive` installation method, and the other to test the `package` installation method. Each vagrant box also runs elasticsearch.

At this time these tests are fairly basic. We use a basic manifest in each case and ensure that the puppet return code is 2 (the run succeeded, and some resources were changed) on the first run, and ensure that the return code is 0 (the run succeeded with no changes or failures; the system was already in the desired state) on the second run.

Available node sets are centos-66-x64, centos-70-x64, ubuntu-1204-x64, ubuntu-1404-x64, debian-78-x64.

Run with:
```
$ BEAKER_set=centos-66-x64 bundle exec rspec spec/acceptance
```
