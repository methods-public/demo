# ruby-enterprise-install [![Build Status](https://secure.travis-ci.org/bacrossland/ruby-enterprise-install.png?branch=master)](http://travis-ci.org/bacrossland/ruby-enterprise-install)

Description
===========

Installs Ruby Enterprise Edition (REE) by Phusion with patches from the github repo http://github.com/bacrossland/ruby_enterprise
REE is no longer supported. You should migrate off it as soon as you can. This cookbook is here to help you do that by
installing REE onto newer OS versions of Ubuntu, CentOS, and Fedora. It's based off the no longer maintained
cookbook ruby_enterprise (https://github.com/miketheman/ruby_enterprise).

Requirements
============

## Cookbooks:
* `build-essential` - get a compiler and associated files
* `apt` - package manager for Ubuntu
* `yum` - package manager for CentOS and Fedora

Attributes
==========

* `node['ruby_enterprise']['install_path']` - Location to install REE. Default /opt/ruby-enterprise
* `node['ruby_enterprise']['version']` - Version to install. Looks like `1.8.7-2012.02`
* `node['ruby_enterprise']['url']` - URL to download. Default is from GoogleCode, with the version specified

Usage
=====
Include the ruby-enterprise-install recipe to install REE.

    include_recipe "ruby-enterprise-install"

Or add it to your role, or directly to a node's recipes.

Install RubyGems under REE with the ree_gem definition.

    ree_gem "rails" do
      source "http://gems.rubyforge.org"
      version "2.3.4"
    end

The definition supports parameters for source and version, though they are optional.

Note
====
Ruby Enterprise Edition has been dropped.
A [post from Phusion][1] explains the reason for dropping the support.
This cookbook serves as a way to install REE onto new versions of infrastructure.

[1]: http://blog.phusion.nl/2012/02/21/ruby-enterprise-edition-1-8-7-2012-02-released-end-of-life-imminent/

License and Authors
===================

Author:: Bryan Crossland ([bacrossland](https://github.com/bacrossland))
Author:: Mike Fiedler (<miketheman@gmail.com>)
Author:: Joshua Timberman (<joshua@opscode.com>)
Author:: Sean Cribbs (<seancribbs@gmail.com>)
Author:: Michael Hale (<mikehale@gmail.com>)

Copyright:: 2015, Bryan Crossland
Copyright:: 2011-2012, Mike Fiedler
Copyright:: 2009-2010, Opscode, Inc.
Copyright:: 2009, Sean Cribbs
Copyright:: 2009, Michael Hale

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

