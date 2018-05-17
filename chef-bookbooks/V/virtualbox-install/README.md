Description
===========

Installs Virtualbox on OS X, Debian/Ubuntu or Windows.

Changes
=======

[CHANGELOG.md](CHANGELOG.md)

Requirements
============

Requires Chef version 12.14+

## Platform:

* Mac OS X
* Ubuntu and Debian, 64 bit (amd64/x86\_64)
* RHEL/CentOS (tested on 6.3)
* Windows

Other related platform family distributions may work.

## Cookbooks

You'll also need the respective package manager cookbook for your platform:

* dmg (for OS X installation)
* apt (for Debian family)
* yum (for RHEL family)
* windows (for Windows installation)

These are dependencies to ensure that the recipes work when using Chef
Solo, and because it's the right thing to do.

Attributes
==========

* `node['virtualbox']['url']` - URL to the VirtualBox download file.
  Used on Windows and OS X only to the ".exe" or ".dmg," respectively.
* `node['virtualbox']['version']` - Version of VirtualBox package to
  install. On Windows, this is automatically detected with the
  Vbox::Helpers module as the three-dotted version (e.g., 4.2.8). On
  Debian and RHEL platforms, this is the version suffix for the
  package to ensure that the correct version from the Virtualbox
  repository is installed (e.g., 4.2).

Deprecated/unused attributes:

* `node['virtualbox']['urlbase']` - This is automatically
  used/calculated in the Vbox::Helpers module and not used elsewhere.
* `node['virtualbox']['arch']` - This was used for architecture
  specific packages for Linux distributions, which is deprecated in
  favor of the package repository.
* `node['virtualbox']['open_source_edition']` - This was not used in
  any recipe / template in this cookbook and has been removed.

Recipes
=======

# default

This recipe will install VirtualBox for supported platforms. On
Windows and OS X, the file specified by the url attribute (see above)
will be downloaded and installed. On Linux (Debian and RHEL families
are supported), the appropriate OS package repository will be added
(apt or yum, respectively), along with Oracle's VirtualBox package
signing key, and the package installed from the repository. The
packages seem to handle all the kernel module recompilation, so this
recipe doesn't handle that.

# Other recipes

## user

Creates a user to run the system service and web service as.  This recipe
is implicitly included in the "webservice", "webportal", and "systemservice"
recipes.

#### Attributes:

* `node['virtualbox']['user']` - User name to create.  Defaults to `virtualbox`.
* `node['virtualbox']['group']` - Group for user.  Defaults to `vboxusers`.

#### Databags:

* `passwords/virtualbox-user` - Must contain a "password" attribute which sets
  the password for the VirtualBox user.

A sample data bag looks like:
    {
      "id" : "virtualbox-user",
      "password" : "virtualbox"
    }

## systemservice

Creates a system service that will run virtual machines at startup.  Add UIDs of
any machines you want started to /etc/virtualbox/machines_enabled.

## webservice

Installs a web service which allows remote control of VirtualBox.  This is
implicity included in the "webportal" recipe.  Note that the webservice is
installed with no authentication, so make sure you have a firewall set up
or that you are on a trusted network!

## webportal

Installs apache2 and a [phpvirtualbox](http://sourceforge.net/projects/phpvirtualbox/)
to provide a web console to manage VirtualBox.  Note by default phpvirtualbox is
installed to /var/www.  For the default install, it is recommended that you set
`node['apache']['default_site_enabled']` to true, but you can also create your own
site for phpvirtualbox if you don't want to use the default site.

#### Attributes:

* `node['virtualbox']['webportal']['installdir']` - Directory to install phpvirtualbox to.
  Defaults to /var/www.


Helper Library
==============

The Vbox::Helpers module includes two methods.

* `vbox_sha256sum` - Given an absolute URL to the VirtualBox download
  file (.exe or .dmg), the SHA256 checksum will be retrieved from the
  VirtualBox site. This assumes the default URLs from virtualbox.org's
  download site, and may be quite brittle if you're hosting your own
  packages.

* `vbox_version` - Given an absolute URL to the download file, the
  version is calculated. This is used on Windows systems because the
  "package" name in Windows includes the version.

Usage
=====

Include the virtualbox default recipe in a role run list. If you want
to install from a different source URL, provide it with the url
attribute and the version if the Vbox::Helpers library cannot determine
it, such as:

    name "role_for_vbox"
    default_attributes(
      "virtualbox" => {
        "url" => "http://url.to/your/vbox.pkg",
        "version" => "4.2"
      })
    run_list("recipe[virtualbox]")

Contributions
=============

The source for this cookbook is hosted on
[GitHub](https://github.com/spion06/virtualbox-install_chef). If you have any issues
with this cookbook, please follow up there.

License and Author
==================

* Forked from https://github.com/bradleyd/virtualbox-cookbook and https://github.com/jtimberman/virtualbox-cookbook

* Author: Kyle McGovern <spion06@gmail.com>

* Copyright 2018, Kyle McGovern <spion06@gmail.com>
* Copyright 2011-2013, Joshua Timberman

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
