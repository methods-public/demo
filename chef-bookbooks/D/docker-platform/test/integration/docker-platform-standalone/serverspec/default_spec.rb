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

describe 'Docker' do
  it 'has the latest alpine image' do
    cmd = 'docker images | grep "alpine *latest"'
    result = `#{cmd} 2>&1`
    expect(result).to include('alpine')
  end

  it 'has the latest busybox image' do
    cmd = 'docker images | grep "busybox *latest"'
    result = `#{cmd} 2>&1`
    expect(result).to include('busybox')
  end

  it 'has an_echo_server container running' do
    cmd = 'docker ps --format="{{.Names}}"'
    result = `#{cmd} 2>&1`
    expect(result).to include('an_echo_server')
  end
end

describe 'Docker unit' do
  it 'has been fully overriden' do
    result = <<-UNIT.gsub(/^#{' ' * 6}/, '')
      # /etc/systemd/system/docker.service
      [Service]
      ExecStart = /usr/bin/dockerd
    UNIT
    expect(`systemctl cat docker`).to eq result
  end
end
