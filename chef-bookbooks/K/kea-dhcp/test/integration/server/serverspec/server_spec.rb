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

describe service('kea-dhcp4') do
  it { should be_enabled }
  it { should be_running }
end

describe interface('eth1') do
  it { should exist }
  it { should be_up }
  it { should have_ipv4_address('10.0.1.1/16') }
end

describe file('/etc/kea/kea.conf') do
  its(:content) { should contain '"pool": "10.0.1.2 - 10.0.127.240"' }
  its(:content) { should contain '"output": "/var/log/kea-dhcp4-role.log"' }
end

describe file('/etc/sysconfig/network-scripts/ifcfg-eth1') do
  its(:content) { should eq <<-CONF.gsub(/^ {4}/, '') }
    # This file maintained by Chef.  DO NOT EDIT!

    DEVICE="eth1"
    TYPE="Ethernet"
    ONBOOT="yes"
    BOOTPROTO="static"
    IPADDR="10.0.1.1"
    NETMASK="255.255.0.0"
    NM_CONTROLLED="no"
  CONF
end

describe service('dhcp-client-exporter.timer') do
  it { should_not be_enabled }
  it { should_not be_running }
end
