# yum-atrpms Cookbook CHANGELOG
This file is used to list changes made in each version of the yum-atrpms cookbook.

## 2.0.1 (2016-12-22)

- Deprecate this cookbook as the atrpms repo is no more
- Depend on the latest compat_resource cookbook

## 2.0.0 (2016-11-25)
- Replace yum dependency with compat_resource
- Convert to inspec from bats

## 1.0.0 (2016-09-06)
- Testing updates
- Resolve rubocop warnings
- Add chef_version metadata
- Remove Chef 11 support

## v0.1.3 (2015-12-01)
- Fixing if/unless logic in recipes

## v0.1.2 (2015-10-28)
- Fixing Chef 13 warnings by not passing nils

## v0.1.1 (2015-09-22)
- Add support for Amazon linux
- Update yum depencency from ~3.0 to ~3.2
- Added source_url and issues_url metadata
- Added the standard chef rubocop config
- Added standard Chef gitignore and chefignore files
- Update berksfile API endpoint
- Update distro versions in the Kitchen config
- Added Fedora 20 to the Travis config
- Add Travis CI and cookbook version badges in the readme
- Expand the requirements section in the readme
- Update contributing, maintainers, and testing docs
- Add standard Gemfile with testing and development dependencies
- Update Chefspec config to 4.X format

## v0.1.0 (2014-09-22)
- Initial Release
