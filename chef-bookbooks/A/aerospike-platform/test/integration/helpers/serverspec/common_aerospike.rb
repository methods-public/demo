# Copyright (c) 2015-2016 Sam4Mobile, 2018 Make.org
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

def wait_cluster_size
  (1..20).each do |try|
    log = `cat /opt/aerospike/var/log/aerospike.log`
    break if log.include?('CLUSTER-SIZE 3')
    puts "Waiting for correct cluster size. Try ##{try}/20, waiting 5s"
    sleep(5)
  end
end

wait_service('aerospike', 3000)
wait_service('aerospike fabric', 7001)
wait_service('aerospike info', 7002)
wait_service('aerospike heartbeat', 8002)

describe 'Aeropsike Daemon' do
  it 'is listening on port 3000' do
    expect(port(3000)).to be_listening
  end
end

describe 'Aerospike fabric' do
  it 'is listening on port 7001' do
    expect(port(7001)).to be_listening
  end
end

describe 'Aerospike info' do
  it 'is listening on port 7002' do
    expect(port(7002)).to be_listening
  end
end

describe 'Aerospike heartbeat' do
  it 'is listening on port 8002' do
    expect(port(8002)).to be_listening
  end
end

describe file('/opt/aerospike/var/log/aerospike.log') do
  wait_cluster_size
  its(:content) { should contain 'CLUSTER-SIZE 3' }
end
