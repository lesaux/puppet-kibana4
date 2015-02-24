# kibana4

[![Build Status](http://img.shields.io/travis/lesaux/puppet-kibana4.svg)](http://travis-ci.org/lesaux/puppet-kibana4)


#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with kibana4](#setup)
    * [What kibana4 affects](#what-kibana4-affects)
    * [Beginning with kibana4](#beginning-with-kibana4)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

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


## Reference

This module uses camptocamp/archives to download and extract the Kibana4 archive.

## Limitations

Basic spec testing is done, but no tests on the generate config file is done at the moment.

