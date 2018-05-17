#
# Cookbook Name:: ceph_micro
# Recipe:: default
#
# Copyright (C) 2014 Sofer Athlan-Guyot
#
# All rights reserved - Do Not Redistribute
#
template "/tmp/micro-osd.sh" do
  source "micro-osd.sh.erb"
end

template "/etc/profile.d/ceph.sh" do
  source "ceph.sh.erb"
end

if platform_family?("rhel")
  node.set['yum-epel']['repositories'] = %w{epel}
  include_recipe 'yum-epel'
elsif platform_family?("debian")
  include_recipe 'apt'
end

include_recipe 'python'

bash "install ceph" do
  code <<-EOC
bash /tmp/micro-osd.sh #{node['ceph_micro']['path']}
EOC
end
