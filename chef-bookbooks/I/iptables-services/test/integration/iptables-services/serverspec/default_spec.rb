#
# Copyright (c) 2017-2018 Make.org
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

inets = Socket.getifaddrs.select do |ifaddr|
  ifaddr.name == 'eth0' && !ifaddr.addr.nil? && ifaddr.addr.ipv4?
end
my_ip = inets.map { |i| i.addr.ip_address }.first

to_check = {
  'iptables' => {
    'filter' => {
      'INPUT' => <<-TABLE.gsub(/^ */, ''),
      -P INPUT ACCEPT
      -A INPUT -i lo -j ACCEPT
      -A INPUT -i eth0 -j ACCEPT
      -A INPUT -p icmp -j ACCEPT
      -A INPUT -m state --state ESTABLISHED -j ACCEPT
      -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
      -A INPUT -j REJECT --reject-with icmp-host-prohibited
      TABLE
      'OUTPUT' => <<-TABLE.gsub(/^ */, ''),
      -P OUTPUT ACCEPT
      -A OUTPUT -p icmp -j ACCEPT
      -A OUTPUT -j ACCEPT
      TABLE
      'MINE' => <<-TABLE.gsub(/^ */, ''),
      -N MINE
      -A MINE -j ACCEPT
      TABLE
      'PREV-UNDEFINED' => <<-TABLE.gsub(/^ */, ''),
      -N PREV-UNDEFINED
      -A PREV-UNDEFINED -i lo -j ACCEPT
      -A PREV-UNDEFINED -j REJECT --reject-with icmp-port-unreachable
      TABLE
      'UNDEFINED' => <<-TABLE.gsub(/^ */, ''),
      -N UNDEFINED
      TABLE
      'DOCKER-USER' => <<-TABLE.gsub(/^ */, ''),
      -N DOCKER-USER
      -A DOCKER-USER -s #{my_ip}/32 -j RETURN
      -A DOCKER-USER -s 192.168.255.254/32 -j RETURN
      -A DOCKER-USER -i eth1 -j REJECT --reject-with icmp-host-prohibited
      -A DOCKER-USER -j RETURN
      TABLE
    },
    'mangle' => {
      'PREROUTING' => <<-TABLE.gsub(/^ */, ''),
      -P PREROUTING ACCEPT
      TABLE
    }
  },
  'ip6tables' => {
    'filter' => {
      'INPUT' => <<-TABLE.gsub(/^ */, ''),
        -P INPUT ACCEPT
        -A INPUT -j REJECT --reject-with icmp6-port-unreachable
      TABLE
      'FORWARD' => <<-TABLE.gsub(/^ */, ''),
        -P FORWARD ACCEPT
        -A FORWARD -j DROP
      TABLE
    }
  }
}

to_check.each do |type, tables|
  describe type do
    tables.each do |table, chains|
      chains.each do |chain, output|
        it "should have correct #{chain} chain in #{table} table" do
          cmd = "#{type} -S #{chain} -t #{table}"
          expect(command(cmd).stdout).to eq(output)
        end
      end
    end
  end
end

describe 'iptables manually-added rules' do
  it 'should replaced if conflicting with configured ones' do
    rule = '-A INPUT -p tcp -m tcp --dport 80 -j ACCEPT'
    expect(iptables).to_not have_rule(rule)
  end
  it 'should be kept if we do not configure the same chain' do
    rule = '-A INPUT -j ACCEPT'
    expect(iptables).to have_rule(rule).with_table('nat')
  end
end

describe 'ip6tables manually-added rules' do
  it 'should replaced if conflicting with configured ones' do
    rule = '-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT'
    expect(ip6tables).to_not have_rule(rule)
  end
  it 'should be kept if we do not configure the same chain' do
    rule = '-A OUTPUT -j DROP'
    expect(ip6tables).to have_rule(rule).with_chain('OUTPUT')
  end
end

describe 'docker rules' do
  it 'should be preserved in filter' do
    rule = '-A DOCKER -d 172.17.0.2/32 ! '\
      '-i docker0 -o docker0 -p tcp -m tcp --dport 7777 -j ACCEPT'
    expect(iptables).to have_rule(rule).with_table('filter')
  end
  it 'should be preserved in nat' do
    rule = '-A POSTROUTING -s 172.17.0.2/32 '\
      '-d 172.17.0.2/32 -p tcp -m tcp --dport 7777 -j MASQUERADE'
    expect(iptables).to have_rule(rule).with_table('nat')
  end
end
