#
# Cookbook Name:: mariadb_galera
# Recipe:: firewall
#
# Copyright (c) 2016 Robert Ressl, All Rights Reserved.

firewall_rule 'galera_tcp' do
  port     [3306, 4567, 4568, 4444]
  protocol :tcp
  command  :allow
end

firewall_rule 'galera_udp' do
  port     [4567]
  protocol :udp
  command  :allow
end
