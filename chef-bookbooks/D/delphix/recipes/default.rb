#
# Cookbook:: delphix
# Recipe:: default
#
# Copyright:: Copyright (c) 2018 by Delphix. All rights reserved.

case node["platform"]
when "redhat"
  include_recipe "delphix::redhat"
when "debian"
  include_recipe "delphix::debian"
end

include_recipe "delphix::config_targethost"
