#
# Copyright (c) 2016 Sam4Mobile, 2018 Make.org
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
require 'aerospike'

def wait_server_availability(addr)
  (1..20).each do |try|
    break if Aerospike::Client.new(addr)
    puts "Waiting for #{addr} availability . Try ##{try}/20, waiting 5s"
    sleep(5)
  end
end

def wait_key_replication(server, node_name, kitchen_instance)
  (1..20).each do |try|
    break if read_key(server, kitchen_instance).include?(node_name)
    puts "Waiting for key replication on #{server}. Try ##{try}/20, waiting 5s"
    sleep(5)
  end
end

def write_key(addr, node_name, kitchen_instance)
  client = Aerospike::Client.new(addr)
  key = Aerospike::Key.new('kitchen', kitchen_instance, 'key')
  bin = {
    kitchen_instance => node_name
  }
  client.put(key, bin)
end

def read_key(addr, kitchen_instance)
  client = Aerospike::Client.new(addr)
  key = Aerospike::Key.new('kitchen', kitchen_instance, 'key')
  resp = client.get(key)
  resp.bins.to_s
end

def exist_key?(addr, kitchen_instance)
  client = Aerospike::Client.new(addr)
  key = Aerospike::Key.new('kitchen', kitchen_instance, 'key')
  client.exists(key)
end

hosts = [
  'aerospike-platform-01-centos-7',
  'aerospike-platform-02-centos-7',
  'aerospike-platform-03-centos-7'
]

node_name = host_inventory['hostname']
kitchen_instance = node_name[/0.*/].to_s

describe 'Replication' do
  hosts.each do |server|
    next if server == node_name
    it "#{server} should have #{node_name} key created" do
      # Check other node availability
      wait_server_availability(server)
      # Write key on the local server if not already created
      next if exist_key?(server, kitchen_instance)
      write_key(node_name, node_name, kitchen_instance)
      # Check if key is replicated on other servers
      wait_key_replication(server, node_name, kitchen_instance)
      expect(read_key(server, kitchen_instance)).to include(node_name)
    end
  end
end
