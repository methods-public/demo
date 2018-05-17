# Description

This cookbook installs Hazelcast in very basic manner.

# Usage

Modify `default['hazelcast']['download_url']` and `default['hazelcast'][checksum']` to change hazelcast version.
Jar name to use will be extracted from this url.

# Configuration

## Class path

There is hash `node['hazelcast']['class_path']`. Add your custom class pathes here.
Key is for name, value is actual path for class path. Hazelcast jar will be automatically added here.


## Java opts

There is hash `node['hazelcast']['java_opts']`. Add your custom java options here.
Use it to configure both java and hazelcast.
Key is for name, value is actual java option string passed as argument to command line.

Provide your own hazelcast.xml for this in your wrapper cookbook.

# Requirements

## Platform:

* debian
* centos

## Cookbooks:

* ark (>= 0.9)
* runit (>= 1.6)

# Attributes

* `node['hazelcast']['user']` -  Defaults to `hazelcast`.
* `node['hazelcast']['group']` -  Defaults to `hazelcast`.
* `node['hazelcast']['home']` -  Defaults to `/opt/hazelcast`.
* `node['hazelcast']['download_url']` -  Defaults to `https://oss.sonatype.org/content/repositories/releases/com/hazelcast/hazelcast-all/3.4.2/hazelcast-all-3.4.2.jar`.
* `node['hazelcast']['checksum']` -  Defaults to `d80efb8c56373bd175f8a45f300ba3a33d007be2413ccc62a848ade54af04a17`.
* `node['hazelcast']['java_home']` -  Defaults to `nil`.
* `node['hazelcast']['java_opts']` -  Defaults to `{ ... }`.
* `node['hazelcast']['class_path']` -  Defaults to `{ ... }`.

# Recipes

* simple-hazelcast::default - Installs only hazelcast

# License and Maintainer

Maintainer:: Yauhen Artsiukhou (<jsirex@gmail.com>)
Source:: https://github.com/jsirex/simple-hazelcast-cookbook
Issues:: https://github.com/jsirex/simple-hazelcast-cookbook/issues

License:: apache 2
