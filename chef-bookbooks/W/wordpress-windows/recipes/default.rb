#
# Cookbook Name:: wordpress_windows
# Recipe:: default
#
# Copyright 2013, Opscode, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apache2-windows'
include_recipe 'php-windows'

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
::Chef::Recipe.send(:include, Wordpress::GenDBPrefix)

# API keys & salt for wp-config
node.set_unless['wordpress']['keys']['auth']         = secure_password
node.set_unless['wordpress']['keys']['secure_auth']  = secure_password
node.set_unless['wordpress']['keys']['logged_in']    = secure_password
node.set_unless['wordpress']['keys']['nonce']        = secure_password
node.set_unless['wordpress']['salt']['auth']        = secure_password
node.set_unless['wordpress']['salt']['secure_auth'] = secure_password
node.set_unless['wordpress']['salt']['logged_in']   = secure_password
node.set_unless['wordpress']['salt']['nonce']       = secure_password

# DB Prefix for wp-config
node.set_unless['wordpress']['database']['prefix'] = random_wpdbprefix_string

# Download and unzip Wordpress
directory node['wordpress']['windows']['path']['cache'] do
  action :create
end

# Make sure the directory we are extract to exists
directory node['wordpress']['windows']['path']['extract'] do
  action :create
end

if node['wordpress']['version'] == 'latest'
  require 'digest/sha1'
  require 'open-uri'
  local_file = "#{Chef::Config[:file_cache_path]}/wordpress-latest.zip"
  latest_sha1 = open('http://wordpress.org/latest.zip.sha1') {|f| f.read }
  unless File.exists?(local_file) && ( Digest::SHA1.hexdigest(File.read(local_file)) == latest_sha1 )
    remote_file "#{Chef::Config[:file_cache_path]}/wordpress-latest.zip" do
      source "http://wordpress.org/latest.zip"
    end
  end
else
  remote_file "#{Chef::Config[:file_cache_path]}/wordpress-#{node['wordpress']['version']}.zip" do
    source "http://wordpress.org/wordpress-#{node['wordpress']['version']}.zip"
  end
end

# Wordpress Application
windows_zipfile "#{node['wordpress']['windows']['path']['cache']}" do
  source "#{Chef::Config[:file_cache_path]}\\wordpress-#{node['wordpress']['version']}.zip"
  not_if { ::File.exists?("#{node['wordpress']['windows']['path']['install']}/wp-settings.php") }
  action :unzip
end

# Copy Wordpress files to DocumentRoot
windows_batch "copy_wordpress_files" do
  creates "#{node['wordpress']['windows']['path']['install']}/index.php"
  not_if { ::File.exists?("#{node['wordpress']['windows']['path']['install']}/wp-settings.php") }
  code <<-EOH
  xcopy /e #{node['wordpress']['windows']['path']['extract']}\\*.* #{node['wordpress']['windows']['path']['install'].gsub('/', '\\')}\\*.*
  EOH
end

template ::File.join(node['wordpress']['windows']['path']['install'],'wp-config.php') do
  source "wp-config.php.erb"
  action :create
  variables(
    :database        => node[:azure][:mysql][:databasename],
    :user            => node[:azure][:mysql][:username],
    :password        => node[:azure][:mysql][:password],
    :host            => node[:azure][:mysql][:server],
    :dbprefix        => node['wordpress']['database']['prefix'],
    :auth_key        => node['wordpress']['keys']['auth'],
    :secure_auth_key => node['wordpress']['keys']['secure_auth'],
    :logged_in_key   => node['wordpress']['keys']['logged_in'],
    :nonce_key       => node['wordpress']['keys']['nonce'],
    :auth_salt        => node['wordpress']['salt']['auth'],
    :secure_auth_salt => node['wordpress']['salt']['secure_auth'],
    :logged_in_salt   => node['wordpress']['salt']['logged_in'],
    :nonce_salt       => node['wordpress']['salt']['nonce'],
    :from_email      => node['wordpress']['email'],
    :from_name       => node['wordpress']['title'],
    :smtp_server     => node[:azure][:smtp][:server],
    :smtp_username   => node[:azure][:smtp][:username],
    :smtp_password   => node[:azure][:smtp][:password]
  )
end

template ::File.join(node['wordpress']['windows']['path']['admin'],'wp-install-script.php') do
  source "wp-install-script.php.erb"
  action :create
  variables(
     :wordpress_path     => node['wordpress']['windows']['path']['install']
  )
end

postinstall_file="#{node['wordpress']['windows']['path']['admin']}/postinstall.complete"
file "#{postinstall_file}" do
  action :nothing
end

execute "doPostInstall" do
  cwd "#{node['wordpress']['windows']['path']['admin']}"
  command "#{node['php']['windows']['path']}\\php wp-install-script.php \"#{node['wordpress']['title']}\" \"#{node['wordpress']['username']}\" \"#{node['wordpress']['email']}\" \"#{node['wordpress']['password']}\""
  notifies :create, "file[#{postinstall_file}]", :immediately 
  not_if { ::File.exists?("#{postinstall_file}")}
end

# Delete the stuff 
directory node['wordpress']['windows']['path']['cache'] do
  recursive true
  action :delete
end

template ::File.join(node['wordpress']['windows']['path']['admin'],'wp_enable_plugins.php') do
  source "wp_enable_plugins.php.erb"
  action :create
  variables(
     :wordpress_path     => node['wordpress']['windows']['path']['install']
  )
end

remote_file node['wordpress']['cli']['path'] do
  checksum node['wordpress']['cli']['checksum']
  source node['wordpress']['cli']['source']
end

