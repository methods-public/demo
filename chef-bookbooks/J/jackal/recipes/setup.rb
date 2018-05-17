include_recipe 'runit'
include_recipe 'build-essential'

# Create any required directories
node[:jackal][:directories].values.each do |dir_path|
  directory dir_path do
    recursive true
  end
end

# Install any required system packages
node[:jackal][:install][:packages].each do |pkg_name|
  package pkg_name
end

# Install any required gems
node[:jackal][:install][:gems].each do |gem_name, gem_version|
  gem_package gem_name do
    if(gem_version)
      version gem_version
    end
    action :install
    notifies :create, 'ruby_block[jackal_gem_update]'
  end
end

# Provided for notifications on gem updates
ruby_block 'jackal_gem_update' do
  block{ true }
  only_if{ node[:jackal][:setup_complete] }
  action :nothing
end

# Setup user

user node[:jackal][:user][:name] do
  system true
  home node[:jackal][:user][:home]
end

directory node[:jackal][:user][:home] do
  recursive true
  owner node[:jackal][:user][:name]
end
