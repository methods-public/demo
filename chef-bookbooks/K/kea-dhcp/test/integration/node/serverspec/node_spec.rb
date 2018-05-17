#
# Copyright (c) 2015-2016 Sam4Mobile, 2017 Make.org
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'

describe interface('eth1') do
  it { should exist }
  it { should be_up }
  it { should have_ipv4_address('10.0.[0-9]*.[0-9]*/16') }
end

describe file('/etc/sysconfig/network-scripts/ifcfg-eth1') do
  its(:content) { should eq <<-CONF.gsub(/^ {4}/, '') }
    # This file maintained by Chef.  DO NOT EDIT!

    DEVICE="eth1"
    TYPE="Ethernet"
    ONBOOT="yes"
    BOOTPROTO="dhcp"
    LINKDELAY="30"
    NM_CONTROLLED="no"
  CONF
end

describe service('dhcp-client-exporter.service') do
  it { should be_enabled }
end

describe service('dhcp-client-exporter.timer') do
  it { should be_enabled }
end

msg = 'node_ip_valid_lifetime_seconds{network_interface="eth1"}'
(1..20).each do |try|
  cmd = "grep '#{msg}' /var/opt/node_exporter/dhcp-client.prom"
  result = `#{cmd} 2>&1`
  break if result.include?(msg)
  puts "Waiting for dhcp client metrics …\
        Try ##{try}/20, waiting 5s"
  sleep(5)
end

describe file('/var/opt/node_exporter/dhcp-client.prom') do
  it { should contain(msg) }
end

curl = 'http_proxy="" curl -s'
url = 'http://localhost:9100/metrics'
describe command("#{curl} #{url}") do
  its(:stdout) { should contain(msg) }
end
