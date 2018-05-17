# Copyright (c) 2017 Sam4Mobile, 2017-2018 Make.org
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

wait_service('cassandra storage', 7000)
wait_service('cassandra native transport', 9042)

conf_dir = '/opt/cassandra/conf'

describe 'Cassandra Configuration' do
  context 'should integrate user config and merge it with default' do
    describe file("#{conf_dir}/cassandra.yaml") do
      its(:content) { should contain 'cluster_name: test-kitchen' }
      its(:content) { should contain 'chunk_length_kb: 128' }
      its(:content) { should contain 'enabled: false' }
      its(:content) { should contain 'snitch: GossipingPropertyFileSnitch' }
    end
    describe file("#{conf_dir}/jvm.options") do
      its(:content) { should contain '-ea' }
      its(:content) { should contain '-Xmx512m' }
    end
    describe file("#{conf_dir}/cassandra-rackdc.properties") do
      its(:content) { should contain 'rack=kitchen' }
    end
    describe file("#{conf_dir}/logback.xml") do
      its(:content) { should contain '<root level="INFO">' }
      its(:content) { should_not contain '<appender-ref ref="ASYNCDEBUGLOG"' }
    end
    describe file("#{conf_dir}/dummy") do
      its(:content) { should contain 'just to test' }
    end
  end
end

describe 'Cassandra Service' do
  it 'is running' do
    expect(service('cassandra')).to be_running
  end

  it 'is launched at boot' do
    expect(service('cassandra')).to be_enabled
  end
end

describe 'Cassandra storage' do
  it 'is listening on correct port' do
    expect(port(7000)).to be_listening
  end
end

describe 'Cassandra native transport' do
  it 'is listening on correct port' do
    expect(port(9042)).to be_listening
  end
end

describe 'Cassandra node' do
  it 'is able to gossip and is in the kitchen rack' do
    cmd = '/opt/cassandra/bin/nodetool info | awk \'$1=$1\''
    result = `#{cmd} 2>&1`
    expect(result).to include('Gossip active : true')
    expect(result).to include('Rack : kitchen')
  end
end

# tests for exporters
describe service('cassandra-exporter.service') do
  it { should be_enabled }
end

describe service('cassandra-exporter.timer') do
  it { should be_enabled }
end

# cluster is Up and Normal state
msg = 'node_cassandra_cluster_status 0'

(1..30).each do |try|
  cmd = "grep '#{msg}' /var/opt/node_exporter/cassandra.prom"
  result = `#{cmd} 2>&1`
  break if result.include?(msg)
  puts "Waiting for metrics of cassandra …\
        Try ##{try}/30, waiting 5s"
  sleep(5)
end

describe file('/var/opt/node_exporter/cassandra.prom') do
  it { should contain(msg) }
end

# generate a backup somewhere cassandra is allowed to do it
describe command('/opt/bin/cassandra_backup.sh /tmp localhost') do
  it 'should contain creating snapshot' do
    expect(subject.stdout).to match(
      /Requested clearing snapshot\(s\) for \[all keyspaces\]/
    )
  end
  its(:exit_status) { should eq 0 }

  describe command('ls /tmp/cassandra-backup_*.tar.gz | tail -n 1') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match(%r{tmp/cassandra-backup_.*\.tar\.gz}) }
  end

  cmd = 'ls /tmp/cassandra-backup_*.tar.gz | tail -n 1 | xargs tar tf | wc -l'
  describe command(cmd) do
    its(:exit_status) { should eq 0 }
    # check if archive contains something
    its(:stdout) { should(satisfy { |s| s.chomp.to_i > 100 }) }
  end
end
