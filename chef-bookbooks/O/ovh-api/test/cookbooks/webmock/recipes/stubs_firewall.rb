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

# Include init to load all dependencies
include_recipe "#{cookbook_name}::stubs_init"

# Useful variables
url = node['ovh-api']['api-url']
addresses = node['network']['interfaces']['eth0']['addresses']
ip = addresses.select { |_addr, info| info['family'] == 'inet' }.keys.first
fake_ip = '10.0.0.1'

# Stubs definition for firewall recipe
stub_request(:get, "#{url}/ip/#{ip}%2F32/firewall").to_return(
  body: <<-JSON,
    ["#{fake_ip}"]
  JSON
  status: 200
).then.to_return(
  body: <<-JSON,
    ["#{fake_ip}"]
  JSON
  status: 200
).then.to_return(
  body: <<-JSON,
    ["#{fake_ip}", "#{ip}"]
  JSON
  status: 200
)

stub_request(:post, "#{url}/ip/#{ip}%2F32/firewall").with(
  body: "{\"ipOnFirewall\":\"#{ip}\"}"
).to_return(
  body: <<-JSON,
    {
      "ipOnFirewall": "#{ip}",
      "enabled": false,
      "state": "ok"
    }
  JSON
  status: 200
)

stub_request(:get, "#{url}/ip/#{ip}%2F32/firewall/#{ip}").to_return(
  body: <<-JSON,
    {
      "ipOnFirewall": "#{ip}",
      "enabled": false,
      "state": "ok"
    }
  JSON
  status: 200
)

stub_request(:get, "#{url}/ip/#{ip}%2F32/firewall/#{fake_ip}").to_return(
  body: <<-JSON,
    {
      "ipOnFirewall": "#{fake_ip}",
      "enabled": true,
      "state": "ok"
    }
  JSON
  status: 200
)

stub_request(:put, "#{url}/ip/#{ip}%2F32/firewall/#{ip}").with(
  body: '{"enabled":true}'
).to_return(
  body: 'null',
  status: 200
)

stub_request(:put, "#{url}/ip/#{ip}%2F32/firewall/#{fake_ip}").with(
  body: '{"enabled":false}'
).to_return(
  body: 'null',
  status: 200
)

stub_request(:get, "#{url}/ip/#{ip}%2F32/firewall/#{ip}/rule").to_return(
  body: <<-JSON,
    [0, 1, 3, 5]
  JSON
  status: 200
)

stub_request(:get, "#{url}/ip/#{ip}%2F32/firewall/#{ip}/rule/0").to_return(
  body: <<-JSON,
    {
      "protocol": "tcp",
      "source": "any",
      "destinationPort": null,
      "sequence": 0,
      "destination": "#{ip}/32",
      "rule": "permit tcp any #{ip}/32 established",
      "sourcePort": null,
      "state": "ok",
      "tcpOption": "established",
      "creationDate": "2015-12-25T00:00:00+00:00",
      "action": "permit",
      "fragments": false
    }
  JSON
  status: 200
)

stub_request(:get, "#{url}/ip/#{ip}%2F32/firewall/#{ip}/rule/1").to_return(
  body: <<-JSON,
    {
      "protocol": "tcp",
      "source": "any",
      "destinationPort": null,
      "sequence": 1,
      "destination": "#{ip}/32",
      "rule": "permit tcp any #{ip}/32",
      "sourcePort": null,
      "state": "ok",
      "tcpOption": null,
      "creationDate": "2015-12-25T00:00:00+00:00",
      "action": "permit",
      "fragments": false
    }
  JSON
  status: 200
)

stub_request(:get, "#{url}/ip/#{ip}%2F32/firewall/#{ip}/rule/3").to_return(
  body: <<-JSON,
    {
      "protocol": "icmp",
      "source": "any",
      "destinationPort": null,
      "sequence": 3,
      "destination": "#{ip}/32",
      "rule": "deny icmp any #{ip}/32",
      "sourcePort": null,
      "state": "ok",
      "tcpOption": null,
      "creationDate": "2015-12-25T00:00:00+00:00",
      "action": "deny",
      "fragments": false
    }
  JSON
  status: 200
)

stub_request(:get, "#{url}/ip/#{ip}%2F32/firewall/#{ip}/rule/5").to_return(
  body: <<-JSON,
    {
      "protocol": "tcp",
      "source": "1.2.3.4/32",
      "destinationPort": "eq 22",
      "sequence": 5,
      "destination": "#{ip}/32",
      "rule": "permit tcp any 1.2.3.4/32 #{ip}/32 eq 22",
      "sourcePort": null,
      "state": "ok",
      "tcpOption": null,
      "creationDate": "2015-12-25T00:00:00+00:00",
      "action": "permit",
      "fragments": false
    }
  JSON
  status: 200
)

stub_request(:delete, "#{url}/ip/#{ip}%2F32/firewall/#{ip}/rule/1").to_return(
  body: 'null',
  status: 200
)

stub_request(:post, "#{url}/ip/#{ip}%2F32/firewall/#{ip}/rule").with(
  body: <<-JSON.gsub(/\s+/, ''),
    {
      "action":"deny",
      "protocol": "udp",
      "sequence":2
    }
  JSON
).to_return(
  body: 'null',
  status: 200
)

stub_request(:delete, "#{url}/ip/#{ip}%2F32/firewall/#{ip}/rule/3").to_return(
  body: 'null',
  status: 200
)
