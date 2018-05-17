# X2go Server Cookbook CHANGELOG

This file is used to list changes made in each version of the x2go-server
cookbook.

## 1.4.2 (2018-05-02)

- Inherit test configs from a central repo where possible
- Ensure gnupg is installed on Debian platforms
- Run integration tests with Microwave

## 1.4.1 (2018-03-08)

- Fix new style offenses

## 1.4.0 (2018-02-23)

- Use keyserver.ubuntu.com instead of keys.gnupg.net

## 1.3.0 (2018-02-22)

- Update to support yum-epel 3.0

## 1.2.0 (2018-02-01)

- Bump the yum-epel cookbook dependency
- Update all the build/test boilerplate
- Resolve all existing style offenses

## 1.1.0 (2016-07-18)

- Remove direct dependency on the apt cookbook

## 1.0.0 (2016-05-12)

- Update apt cookbook dependency
- Convert to custom resources, breaking compatibility with Chef 11
- Start testing against Ubuntu 16.04

## 0.2.1 (2015-10-26)

- Fix bug with service not being started in Chef 12.5.x
- Move the Fedora app provider around to bypass issues with the ordering of
  multiple providers for a platform behaving differently in different versions
  of Chef

## 0.2.0 (2015-09-27)

- Add RHEL and RHEL-alike support
- Add Fedora support

## 0.1.1 (2015-09-16)

- Loosen the version constraint for the apt cookbook dependency

## 0.1.0 (2015-09-15)

- Initial release, w/ support for Ubuntu only

## 0.0.1 (2015-09-11)

- Development started
