#
# Copyright (c) 2015-2017 Sam4Mobile, 2017-2018 Make.org
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

sigs = Marshal.load( # rubocop:disable Security/MarshalLoad
  File.read('/tmp/executed_requests')
)
WebMock.reset!
sigs.each do |request, count|
  WebMock::RequestRegistry.instance.requested_signatures.put(request, count)
end
save = WebMock::RequestRegistry.instance.requested_signatures

url = 'https://api.ovh.com/1.0'
inets = Socket.getifaddrs.select do |ifaddr|
  ifaddr.name == 'eth0' && !ifaddr.addr.nil? && ifaddr.addr.ipv4?
end
ip = inets.map { |i| i.addr.ip_address }.first

describe 'init recipe' do
  it "should request information on primary IP (#{ip})" do
    WebMock::RequestRegistry.instance.requested_signatures = save
    expect(WebMock).to have_requested(:get, "#{url}/ip/#{ip}%2F32")
  end
end
