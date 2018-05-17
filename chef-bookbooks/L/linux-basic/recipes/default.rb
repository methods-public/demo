#
# Cookbook Name:: linux-basic
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# All rights reserved - Do Not Redistribute
#

node.from_file(run_context.resolve_attribute('linux-basic', 'default'))

# include_recipe 'linux-basic::security'
# include_recipe 'linux-basic::files'
# include_recipe 'linux-basic::repo'
# include_recipe 'linux-basic::packages'
# include_recipe 'linux-basic::users'
# include_recipe 'linux-basic::coredump'

# include_recipe 'linux-basic::system'
# include_recipe 'linux-basic::security'
# include_recipe 'linux-basic::crontab'
# include_recipe 'linux-basic::profile'

# include_recipe 'ntp'
