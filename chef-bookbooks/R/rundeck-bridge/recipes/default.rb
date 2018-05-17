#
# Cookbook: rundeck-bridge
# Recipe:   default
#
=begin
#<
This recipe call config recipe and setup a chef-rundeck service that host all bridges
#>
=end

include_recipe 'rundeck-bridge::install'
include_recipe 'rundeck-bridge::config'
include_recipe 'rundeck-bridge::service'
