# Install Gitlab's dependencies as the RPM doesn't
node['gitlab-ce']['dependencies'].each { |pkg| package pkg }

# Gitlab needs potfix to send outgoing email
if node['gitlab-ce']['manage_postfix']
  package 'postfix'
  service 'postfix' do
    supports restart: true, reload: true, status: true
    action [:enable, :start]
  end
end

# Set-up gitlab-ce omnibus repo
include_recipe 'yum-gitlab-ce::default' if node['gitlab-ce']['manage_repo']

# Install gitlab-ce
package 'gitlab-ce'

# Manage configuration
template '/etc/gitlab/gitlab.rb' do
  cookbook 'gitlab-ce'
  source 'gitlab.rb.erb'
  mode '0600'
  owner 'root'
  group 'root'
  notifies :run, 'execute[gitlab-reconfigure]', :immediately
end

execute 'gitlab-reconfigure' do
  command 'gitlab-ctl reconfigure'
  action :nothing
end
