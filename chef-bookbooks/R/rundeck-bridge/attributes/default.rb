#
# Cookbook:   rundeck-bridge
# Attributes: default
#

#<> Service user on bridge
default['rundeck_bridge']['user']    = 'chef-rundeck'
default['rundeck_bridge']['group']   = 'chef-rundeck'
#<> Home of service user
default['rundeck_bridge']['home']    = '/home/chef-rundeck'

# Service set up
default['rundeck_bridge']['gem']['name']  = 'chef-rundeck'
default['rundeck_bridge']['gem']['version']  = nil
#<> Location of chef-rundeck gem binary
default['rundeck_bridge']['binary']  = '/opt/chef/embedded/bin/chef-rundeck'
#<> IP to bind the bridge to
default['rundeck_bridge']['options']['host'] = '0.0.0.0'
#<> Port the bridge listens to
default['rundeck_bridge']['options']['port'] = '9980'
#<> Lighten load on chef-server using partial search instead of classic search
default['rundeck_bridge']['options']['partial-search'] = 'true'
#<> Default username attribute for the node element in the generated resource xml
default['rundeck_bridge']['options']['username'] = 'rundeck'


# Service setup (Using 'poise')
default['rundeck_bridge']['poise_service']['options'] = {
  upstart: {
  },
  systemd: {
  }
}
