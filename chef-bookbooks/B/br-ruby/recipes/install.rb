#
# Cookbook Name:: br-ruby
# Recipe:: install
#

installer = {
  'name' => node['ruby']['installer'],
  'attributes' => node['ruby']['installers'][node['ruby']['installer']]
}

node['ruby']['versions'].each do |version|
  ruby_runtime version do
    install_path node['ruby']['install_path']
    owner node['ruby']['owner']
    group node['ruby']['group']
    mode node['ruby']['mode']
    dependencies node['ruby']['dependencies']
    gems node['ruby']['gems']
    installer installer

    action :install
  end
end
