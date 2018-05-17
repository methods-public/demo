#
# Author:: Barclay Loftus (<barclay@deliv.co>)
# Cookbook:: looker
# Recipe:: user
#

# add the looker group and user
#
user node['looker']['looker_user'] do
  comment 'Create the looker user'
  home node['looker']['home_dir']
  manage_home true
  action :create
end

group node['looker']['looker_group'] do
  append true
  members node['looker']['looker_user']
  action :create
end

# Ensure ulimits are properly set, if there are any
#
if node['looker']['looker_user_ulimit']
  execute 'Set ulimit for looker user' do
    user 'root'
    command "echo \"#{node['looker']['looker_user']} hard nofile #{node['looker']['looker_user_ulimit']}\" >> /etc/security/limits.conf && "\
            "echo \"#{node['looker']['looker_user']} soft nofile #{node['looker']['looker_user_ulimit']}\" >> /etc/security/limits.conf && "\
            'sysctl -p'
    not_if "grep #{node['looker']['looker_user']} /etc/security/limits.conf"
  end
end
