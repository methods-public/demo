include_recipe 'chef-dk'

chef_dk_gem_gem 'knife-supermarket' do
  user 'root'
  action :install
  version '0.2.1'
end
