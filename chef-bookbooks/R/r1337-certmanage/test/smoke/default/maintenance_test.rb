#
# Cookbook Name:: r1337-certmanage
# Spec:: maintenance
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# # encoding: utf-8

# Inspec test for recipe r1337-certmanage::maintenance

if ['ubuntu', 'centos'].include?(os[:name])

  # Test for various fake unapproved files added outside of Chef resources to verify cleanup works
  describe file('/data/ssl/unapprovedfile.txt') do
    it { should_not exist }
  end

  describe file('/data/ssl/certs/baddir') do
    it { should_not exist }
  end

  describe file('/data/ssl/certs/baddir/fakekey.txt') do
    it { should_not exist }
  end
end