# kibana4

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

If applicable, this section should have a brief description of the technology
the module integrates with and what that integration enables. This section
should answer the questions: "What does this module *do*?" and "Why would I use
it?"

If your module has a range of functionality (installation, configuration,
management, etc.) this is the time to mention it.

## Setup

### What kibana4 affects

* Downloads and extracts the kibana4 archive
* Optionally create a user to use for the service
* Creates an initrd file as one is not yet provided by the archive
* Modifies configuration file if needed.
* Java installation is not managed by this module.

### Beginning with kibana4

include kibana4

## Usage

If you decided to have the module create a user, you will need to specify
user name, group name, uid and gid.

```
  class { '::kibana4':
    version         => '4.0.0-linux-x64',
    install_method  => 'archive',
    symlink         => false,
    create_user     => true,
    kibana4_user    => kibana4,
    kibana4_group   => kibana4,
    kibana4_gid     => 200,
    kibana4_uid     => 200,
  }
```

## Parameters

Check all parameters in init.pp file
 [*ensure*]

Should the service be started. Valid values are stopped (false) and running (true)

 [*enable*]

Should the service be enabled on boot. Valid values are true, false, and manual.

 [*version*]

Version of Kibana4 that gets installed.
Defaults to the latest 4.0.0 version available at the time of module release.

 [*download_url*]

URL to download kibana from iff install_method is 'archive'
Defaults to "https://download.elasticsearch.org/kibana/kibana/kibana-${version}.tar.gz"

 [*install_dir*]
 
Installation directory used iff install_method is 'archive'
Defaults to '/opt'.

 [*install_method*]
Only the "archive" method is supported at the moment

 [*symlink*]

Determines if a symlink should be created in the installation directory for
the extracted archive. Only used if install_method is 'archive'.
Defaults to 'true'.

 [*symlink_name*]

Sets the name to be used for the symlink. The default is '${install_dir}/kibana'.
Only used if install_method is 'archive'.

 [*kibana4_user*]

The user that will run the service. For now installation directory is still owned by root.

 [*kibana4_group*]

The primary group of the kibana user


## Reference

This module uses camptocamp/archives to download and extract the Kibana4 archive.

## Limitations

Basic spec testing is done, but no tests on the generate config file is done at the moment.

