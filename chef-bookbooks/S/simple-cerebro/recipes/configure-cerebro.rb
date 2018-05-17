#
# Cookbook Name:: simple-cerebro
# Recipe:: configure-cerebro
#

template "#{node['cerebro']['dir']}/cerebro/conf/application.conf" do
  source 'cerebro/application.conf.erb'
end
