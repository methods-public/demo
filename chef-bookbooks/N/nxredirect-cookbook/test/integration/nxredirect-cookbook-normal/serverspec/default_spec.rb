#
# Copyright (c) 2016 Sam4Mobile, 2017 Make.org
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

def ip_eth0
  Socket.ip_address_list.find do |addr|
    addr.ipv4? && !addr.ipv4_loopback?
  end.ip_address
end

describe 'NXRedirect' do
  it 'is running' do
    expect(service('nxredirect')).to be_running
  end

  it 'is launched at boot' do
    expect(service('nxredirect')).to be_enabled
  end

  it 'is listening on port 53' do
    expect(port(53)).to be_listening
  end
end

describe 'NXRedirect calls primary first' do
  context host('isc.org') do
    it { should be_resolvable.by('dns') }
  end

  context host('isc.org') do
    its(:ipv4_address) { should eq ip_eth0 }
  end
end

describe 'NXRedirect redirects NXDOMAIN to fallback' do
  it 'Primary should return a NXDOMAIN on wikipedia.org' do
    cmd = 'dig wikipedia.org -p 53053 | grep NXDOMAIN'
    expect(command(cmd).exit_status).to eq 0
  end

  it 'But NXRedirect should return an IP' do
    expect(host('wikipedia.org')).to be_resolvable.by('dns')
  end
end
