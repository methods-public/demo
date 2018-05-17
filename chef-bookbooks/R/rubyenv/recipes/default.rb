#
# Cookbook Name:: rubyenv
# Recipe:: default
#
# Copyright (C) 2016 Dennis Vink
#
# License: MIT (see LICENSE)
#

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"
include_recipe "rbenv::rbenv_vars"

if node['rubyenv']['rubies']
  node['rubyenv']['rubies'].each do |version, default|
    rbenv_ruby version
    rbenv_gem "bundler" do
      ruby_version version
    end
    rbenv_ruby version do
      global true
      only_if { default == true }
    end
  end
end
