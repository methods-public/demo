Description
===========

Sets up DenyHosts

Requirements
============

A system that supports denyhosts. tcp_wrappers

Tested only on centos 6.6

Attributes
==========

node['denyhosts']['config'] - a hash of all configuration
entries, same as in denyhosts.conf . See attributes/default.rb

node['denyhosts']['allowed-hosts'] - an array of IP addresses
that should be whitelisted and never be blocked.

Usage
=====

Add the denyhosts::default recipe to your runlist.
Configure any attributes you need.

