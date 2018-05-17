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
fake_ip = '10.0.0.1'

describe 'firewall recipe' do # rubocop:disable Metrics/BlockLength
  furl = "#{url}/ip/#{ip}%2F32/firewall"

  it "should verify the validity of IPs: #{ip} and #{fake_ip}" do
    WebMock::RequestRegistry.instance.requested_signatures = save
    expect(WebMock).to have_requested(:get, furl).times(3)
  end

  it 'should create the firewall for the server' do
    WebMock::RequestRegistry.instance.requested_signatures = save
    expect(WebMock).to have_requested(:post, furl).with(
      body: "{\"ipOnFirewall\":\"#{ip}\"}"
    )
  end

  it "should enable the firewall on primary IP (#{ip})" do
    WebMock::RequestRegistry.instance.requested_signatures = save
    expect(WebMock).to have_requested(:put, "#{furl}/#{ip}").with(
      body: '{"enabled":true}'
    )
  end

  it "should disable the firewall on secondary IP (#{fake_ip})" do
    WebMock::RequestRegistry.instance.requested_signatures = save
    expect(WebMock).to have_requested(:put, "#{furl}/#{fake_ip}").with(
      body: '{"enabled":false}'
    )
  end

  it "should not get rules information for secondary IP (#{fake_ip})" do
    WebMock::RequestRegistry.instance.requested_signatures = save
    expect(WebMock).to have_not_requested(
      :get,
      "#{url}/ip/#{ip}%2F32/firewall/#{fake_ip}/rule"
    )
  end

  it "should keep rule 0: permit tcp any #{ip}/32 established" do
    WebMock::RequestRegistry.instance.requested_signatures = save
    expect(WebMock).to have_not_requested(:delete, "#{furl}/#{ip}/rule/2")
  end

  it "should delete rule 1: permit tcp any #{ip}/32" do
    WebMock::RequestRegistry.instance.requested_signatures = save
    expect(WebMock).to have_requested(:delete, "#{furl}/#{ip}/rule/1")
  end

  it "should add rule 2: deny udp any #{ip}/32" do
    WebMock::RequestRegistry.instance.requested_signatures = save
    expect(WebMock).to have_requested(:post, "#{furl}/#{ip}/rule").with(
      body: '{"action":"deny","protocol":"udp","sequence":2}'
    )
  end

  it "should delete rule 3: deny icmp any #{ip}/32" do
    WebMock::RequestRegistry.instance.requested_signatures = save
    expect(WebMock).to have_requested(:delete, "#{furl}/#{ip}/rule/3")
  end

  it "should keep rule 5: permit tcp any 1.2.3.4/32 #{ip}/32 eq 22" do
    WebMock::RequestRegistry.instance.requested_signatures = save
    expect(WebMock).to have_not_requested(:delete, "#{furl}/#{ip}/rule/5")
  end
end
