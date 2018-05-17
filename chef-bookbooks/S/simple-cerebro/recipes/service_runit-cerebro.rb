#
# Cookbook Name:: simple-cerebro
# Recipe:: service_runit-cerebro
#

include_recipe 'runit'

cfg = ::File.join(node['cerebro']['dir'], 'cerebro', 'conf', 'application.conf')

runit_service 'cerebro' do
  default_logger true
  options(
    'user' => node['cerebro']['user'],
    'home' => ::File.join(node['cerebro']['dir'], 'cerebro')
  )
  subscribes :restart, "file[#{cfg}]"
  subscribes :restart, 'ark[cerebro]'

  action [:enable, :start]
end
