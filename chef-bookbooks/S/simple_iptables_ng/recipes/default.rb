#
# Cookbook Name:: simple_iptables_ng
# Recipe:: default
#
# Copyright 2014, Dan Fruehauf
#
# This file is part of simple_iptables_ng.
#
# simple_iptables_ng is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# simple_iptables_ng is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with simple_iptables_ng.  If not, see <http://www.gnu.org/licenses/>.
#

include_recipe 'iptables-ng::install'

### BEGIN MANDATORY RULES ###
# This is a must rule as well, to allow outgoing connections
iptables_ng_rule '000_established_conns' do
  rule "-m state --state RELATED,ESTABLISHED -j ACCEPT"
end

# Allow all traffic on localhost
iptables_ng_rule '000_localhost' do
  rule "-i lo -j ACCEPT"
end

# Allow SSH from any by default
if node['simple_iptables_ng']['allow_ssh']
  iptables_ng_rule '000_ssh_from_any' do
    rule "-p tcp -s 0/0 --dport 22 -j ACCEPT"
  end
end

# DROP policy for INPUT chain
iptables_ng_chain 'INPUT' do
  policy 'DROP [0:0]'
end

# ACCEPT policy for OUTPUT chain
iptables_ng_chain 'OUTPUT' do
  policy 'ACCEPT [0:0]'
end
### END MANDATORY RULES ###

# Firewall rules from data bags
firewall_rules = []

node['simple_iptables_ng']['entries'].each do |firewall_entry|
  if firewall_entry['data_bag']
    # Rules from defined data bag
    firewall_data_bag = data_bag_item("simple_iptables_ng", firewall_entry['data_bag'])
    firewall_data_bag['entries'].each do |firewall_entry_db|
      firewall_rules.concat(firewall_entry_db['rules'])
    end
  else
    firewall_rules.concat(firewall_entry['rules'])
  end
end

# Clear old rules from previous runs
for i in firewall_rules.size..node['simple_iptables_ng']['max_rules'] do
  rule_to_delete = "/etc/iptables.d/filter/INPUT/chef_iptables_#{i}.rule_v4"
  if(File.exists?(rule_to_delete))
    Chef::Log.info("Deleting rule #{rule_to_delete}")
    execute "rm -f #{rule_to_delete}" do
      notifies :create, 'ruby_block[restart_iptables]', :delayed
    end
  end
end

Chef::Log.info("--- BEGIN IPTABLES FIREWALL ---")

rule_number = 0
firewall_rules.each do |firewall_rule|
  from_addr  = firewall_rule['from_addr']
  proto      = firewall_rule['proto'] || 'tcp'
  start_port = firewall_rule['start_port']
  end_port   = firewall_rule['end_port'] || start_port

  # Build a comma separated list of ports
  ports = start_port.to_s
  if end_port > start_port
    ports += ":#{end_port}"
  end

  # UDP protocols do not support states
  state = ""
  if "tcp" == proto
    state = "-m state --state NEW"
  end

  iptables_ng_rule "chef_iptables_#{rule_number}" do
    ip_version 4
    rule       "-p #{proto} #{state} -s #{from_addr} --dport #{ports} -j ACCEPT"
  end
  rule_number += 1

  Chef::Log.info("iptables rule: #{from_addr}:#{proto}:#{start_port}:#{end_port}")
end

Chef::Log.info("--- END IPTABLES FIREWALL ---")
