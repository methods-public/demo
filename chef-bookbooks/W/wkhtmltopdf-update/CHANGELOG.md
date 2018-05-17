## 0.5.1

* Removed the unused and deprecated `replaces` keyword from the metadata.rb
* Updated the README to use 0.a.x instead of each version.
* Fixed another foodcritic issue. This may break actual installation?

## 0.5.0

* Updated the mirror URL to use github.com/wmkhtmltopdf/wkhtmltopdf/releases/downlaod
* Updated the install packages to include x11-dev, zlib1g-dev, libfreetype6-dev (for debian based, need fedora, rhel, centos testing)
* Added Ubuntu 16.04
* Updated Gems
* Updated Berksfile to source to reflect preferred method by Chef
* Updated Travis RVM to 2.4.2
* Updated Rubocop to exclude Vagrantfile and added FrozenStringLiterals

## 0.4.3

* Update the mirror URL to use downloads.wkhtmltopdf.org instead of gna.org

## 0.4.1

* Update the mirror URL to use gna.org instead of sourceforge

## 0.4.0

* Enhancement: [#2]: Changes to use chef package resource to install wkhtmltopdf
* Enhancement: Adds chef_wkhtmltopdf_cleanup recipe to remove wkhtmltopdf installed by previous chef-wkhtmltopdf cookbook

## 0.2.0

* Bugfix: Removed extraneous wkhtmltoimage/wkhtmltopdf attributes
* Enhancement: [#2][]: Updated to wkhtmltopdf 0.12.0
* Enhancement: Consolidated _binary recipes into single binary recipe
* Enhancement: Set lib_dir to install wkhtmltox.so
* Enhancement: Move dependency package installation to dependency_packages attribute and default recipe
* Enhancement: Renamed arch attribute to platform (to better handle download URLs)

## 0.1.0

* Initial release

[#2]: https://github.com/bflad/chef-wkhtmltopdf/issues/2
