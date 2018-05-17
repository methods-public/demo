#
# Cookbook Name:: br-rails
# Recipe:: default
#

include_recipe 'br-rails::configure'
include_recipe 'br-rails::install'
include_recipe 'br-rails::migrate'
