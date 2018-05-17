#
# Author:: Barclay Loftus (<barclay@deliv.co>)
# Cookbook:: looker
# Recipe:: setup
#

include_recipe 'java'

unless node['etc']['passwd'][node['looker']['looker_user']]
  include_recipe 'looker::user'
end

directory node['looker']['looker_dir'] do
  owner node['looker']['looker_user']
  group node['looker']['looker_group']
  mode '0755'
  action :create
end

include_recipe 'looker::ssl' if node['looker']['use_custom_ssl']

# Download looker
# We'll keep a local copy of it in the home directory, for convienience
#
looker_download = File.join(node['looker']['home_dir'], "looker_v#{node['looker']['major_version']}-#{node['looker']['minor_version']}.jar")
remote_file looker_download do
  source node['looker']['download_url']
  owner node['looker']['looker_user']
  group node['looker']['looker_group']
  mode '0750'
  action :create_if_missing
end

# move it into position, but re-write it even if it exists
#
execute 'Copy the looker.jar into the working directory' do
  command "cp #{looker_download} #{node['looker']['looker_jar_file']}"
  cwd node['looker']['home_dir']
  user node['looker']['looker_user']
end

# setup the looker start script, and the systemV service
#
template node['looker']['looker_script_name'] do
  source 'looker.erb'
  mode '750'
  owner node['looker']['looker_user']
  group node['looker']['looker_group']
  variables(
    start_args: node['looker']['jar_start_args']
  )
end

template '/etc/systemd/system/looker.service' do
  source 'looker.service.erb'
  mode '644'
  user 'root'
  variables(
    looker_script: node['looker']['looker_script_name'],
    looker_user:   node['looker']['looker_user'],
    looker_dir:    node['looker']['looker_dir']
  )
end

execute 'register the looker service' do
  command 'systemctl daemon-reload && systemctl enable looker.service'
  user 'root'
end

# move everything from 9999 to 443
#
if node['looker']['forward_to_443']
  execute 'update IPTABLES to send 9999 to 443' do
    command 'iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 9999'
    user 'root'
  end
end

include_recipe 'looker::nginx' if node['looker']['use_nginx_frontend']

# now let's startup
#
include_recipe 'looker::start'
