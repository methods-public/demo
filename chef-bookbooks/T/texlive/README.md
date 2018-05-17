Description
===========

Installs TeXLive including many packages of TeX systems

Requirements
============

## Platform

* Linux (I'd tested on CentOS 6.3)

This cookbook needs 4GB+ disk space to install TeXLive.

Attributes
==========

* `node['texlive']['dvd_url']` - URL for TeXLive install DVD image
  Default settings are download it from ftp.jaist.ac.jp .

* `node['texlive']['timeout']` - Timeout for TeXLive installer.
  Default settings are 1800 (30min).

Usage
=====

Simply include the `texlive` and the TeXLive will be installed to your system.
