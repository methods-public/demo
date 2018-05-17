[![Travis-CI Build Status](https://secure.travis-ci.org/stonevil/mono3-cookbook.png?branch=master)](https://travis-ci.org/stonevil/mono3-cookbook)


[![Code Climate](https://codeclimate.com/github/stonevil/mono3-cookbook/badges/gpa.svg)](https://codeclimate.com/github/stonevil/mono3-cookbook)

[![Stories in Ready](https://badge.waffle.io/stonevil/mono3-cookbook.png?label=ready&title=Ready)](https://waffle.io/stonevil/mono3-cookbook)


Description
===========

Installs and configures Mono Framework v3.x. Can optionally build and install Mono Framework from sources.

Requirements
============

Platform:

* Debian 7.8
* Ubuntu 12.04, 14.04
* CentOS 7.0
* RedHat, etc

The following cookbooks are dependencies:

* apt
* yum
* yum-epel
* git
* build-essential

Recipes
=======

* default - the recipe you want in your run-list.

Usage
=====

Simply add the `mono3::default` recipe to the node where you want Mono Framework v3.x installed.

Attributes
==========

Most attributes under mono3 are basic attributes needed for correctly installing the framework.

* ['mono3']['install_method'] - choose installation method: package or source. Source method do not recommended.
* ['mono3']['source']['git_uri'] - git url for Mono sources.
* ['mono3']['source']['git_branch'] - branch name used for source method installation.

License and Author
==================
Author: Myroslav Rys (<stonevil@gmail.com>)
