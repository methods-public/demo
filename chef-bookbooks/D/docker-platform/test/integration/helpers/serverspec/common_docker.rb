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

require 'serverspec'

describe 'Docker' do
  it 'is running' do
    expect(service('docker')).to be_running
  end

  it 'is lauched at boot' do
    expect(service('docker')).to be_enabled
  end
end

# rubocop:disable Metrics/BlockLength
describe 'Docker configuration' do
  it 'daemon.json has storage-driver configuration set' do
    vfs = '"storage-driver": "vfs"'
    expect(file('/etc/docker/daemon.json').content).to contain(vfs)
  end

  it 'daemon is running with correct Storage Driver configuration' do
    result = "Storage Driver: vfs\n"
    expect(command('docker info | grep "Storage Driver"').stdout).to eq(result)
  end

  it 'daemon.json has tls configuration set' do
    tls_config = [
      '"tcp://0.0.0.0:2376"',
      '"unix:///var/run/docker.sock"',
      '"tlsverify": true',
      '"tlscacert": "/root/.docker/ca.pem"',
      '"tlscert": "/root/.docker/cert.pem"',
      '"tlskey": "/root/.docker/key.pem"'
    ]
    tls_config.each do |line|
      expect(file('/etc/docker/daemon.json').content).to contain(line)
    end
  end

  it 'we can list containers with a secure connection' do
    cmd = 'docker --tlsverify -H localhost:2376 ps --format="{{.Names}}"'
    result = `#{cmd} 2>&1`
    compare = `docker ps --format="{{.Names}}" 2>&1`
    expect(result).to eq(compare)
  end
end
# rubocop:enable Metrics/BlockLength
