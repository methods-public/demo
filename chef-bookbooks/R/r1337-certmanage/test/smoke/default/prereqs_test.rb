#
# Cookbook Name:: r1337-certmanage
# Spec:: prereqs
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# # encoding: utf-8

# Inspec test for recipe r1337-certmanage::prereqs

if ['ubuntu', 'centos'].include?(os[:name])

# Validate that the directories we rely on exist and have the correct permissions
  describe file('/data') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0755 }
  end

  describe file('/data/ssl') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0750 }
  end

  describe file('/data/ssl/certs') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0750 }
  end

  describe file('/data/ssl/keys') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0750 }
  end
end