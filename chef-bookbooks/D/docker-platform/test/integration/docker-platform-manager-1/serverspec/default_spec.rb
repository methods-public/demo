#
# Copyright (c) 2016-2017 Sam4Mobile, 2017-2018 Make.org
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
require 'common_docker'

hosts = {
  'docker-platform-manager-1-centos-7' => 'Drain',
  'docker-platform-manager-2-centos-7' => 'Active',
  'docker-platform-manager-3-centos-7' => 'Active',
  'docker-platform-worker-4-centos-7' => 'Active'
}

def wait_replicas_scaling(replicas_number)
  (1..50).each do |try|
    cmd = 'docker service ls --format=\'{{.Replicas}}\''
    result = `#{cmd} 2>&1`.chop
    break if result.include?("#{replicas_number}/#{replicas_number}")
    puts "Waiting 2s for scaling of replicas:(#{result}). Try ##{try}/50"
    sleep(2)
  end
end

def wait_replicas_balancing(server)
  (1..20).each do |try|
    cmd = "docker service ps redis -f node=#{server} -f desired-state=running"
    result = `#{cmd} 2>&1`
    break if result.include?('Running')
    puts "Waiting for balancing of replicas … Try ##{try}/20, waiting 2s"
    sleep(2)
  end
end

def replicas_scaling(replicas_number)
  cmd = "docker service scale redis=#{replicas_number}"
  `#{cmd} 2>&1`
end

def update_service
  cmd = 'docker service update redis --force --detach=false'
  `#{cmd} 2>&1`
end

describe 'Docker unit' do
  it 'has been partly overriden' do
    default = <<-UNIT.gsub(/^#{' ' * 6}/, '')
      [Unit]
      Description=Docker Application Container Engine
      Documentation=https://docs.docker.com
    UNIT

    override = <<-UNIT.gsub(/^#{' ' * 6}/, '')
      # /etc/systemd/system/docker.service.d/override.conf
      [Service]
      ExecStart =
      ExecStart = /usr/bin/dockerd
    UNIT
    expect(`systemctl cat docker`).to include(default, override)
  end
end

describe 'Swarm cluster' do
  hosts.each do |node, mode|
    it "#{node} is available and ready" do
      cmd = "docker node ls --filter name=#{node}"
      result = `#{cmd} 2>&1`
      expect(result).to include(node, 'Ready', mode)
      if node.include?('manager')
        expect(result).to include('Leader').or include('Reachable')
      end
    end
  end
end

up = 6
down = 3
# rubocop:disable Metrics/BlockLength
describe 'Swarm services' do
  it 'has launch redis service with correct options' do
    result = `docker service inspect redis 2>&1`
    expect(result).to include('"SpreadDescriptor": "node.labels.datacenter"',
                              '"SpreadDescriptor": "node.labels.rack"')
  end

  it "is able to scale up the redis service to #{up} replicas" do
    replicas_scaling(up)
    wait_replicas_scaling(up)
    result = `docker service ls 2>&1`
    expect(result).to include('redis', "#{up}/#{up}")
  end

  it "is able to scale down the redis service to #{down} replicas" do
    replicas_scaling(down)
    wait_replicas_scaling(down)
    result = `docker service ls 2>&1`
    expect(result).to include('redis', "#{down}/#{down}")
  end

  hosts.each do |server, mode|
    next unless mode == 'Active'
    it "have running replicas on #{server}" do
      update_service
      wait_replicas_balancing(server)
      cmd =
        "docker service ps redis -f node=#{server} -f desired-state=running"
      result = `#{cmd} 2>&1`
      expect(result).to include(server, 'Running')
    end
  end
end
# rubocop:enable Metrics/BlockLength

describe 'Docker Image registry' do
  it 'does not have redis image on docker-platform-manager-1-centos-7' do
    cmd = 'docker images | grep "redis"'
    result = `#{cmd} 2>&1`
    expect(result).to_not include('redis')
  end
end
