#
# Cookbook Name:: fish-shell
# Recipe:: default
#
# Copyright (c) 2015 ChefFurs
# Licenced under BSD 2-Clause

include_recipe "fish-shell::#{node['fish-shell']['install_method']}"
