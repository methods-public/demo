# CHANGELOG for thruk

This file is used to list changes made in each version of thruk.

## 2.0.0

* Change all of the thruk_local.conf settings to hashes, so that it is more configurable.
* Upgrade thruk to 2.00-2.
* Force apache restart before thruk service starts, so that recipes converge on first run.
* Add default file so that init script works with SSL redirect.
* Fix for fcgid module for Apache 2.4 on CentOS.
* Directory permissions for Apache 2.4.
* Allow loading of SSL certificates and icons from different cookbooks.
* Integration tests for thruk with SSL.
* Integration tests and fixes for CentOS 7.1, Debian 7.8, Debian 8.1, Ubuntu 12.04 and Ubuntu 15.04.

## 1.1.0

* Bugfixes based on new tests! Make sure we are not using mpm_event on apache 2.4, disable new apache thruk.conf, fix apt key import and force thruk to restart whenever apache restarts or reloads.
* Add integration tests with ServerSpec on CentOS 6.6 and Ubuntu 14.10.
* Add unit tests with ChefSpec.

## 1.0.0

* Change default thruk version to 2.00-1
* add ability to install thruk version 2.00 via labs repository for rhel
* add additional configuration properties for shinken and strict_host_authorization

## 0.4.1

* add ability to install thruk version 2.00 via labs repository for debian

## 0.1.0:

* Initial release of thruk

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
