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

# Include init, necessary to get ovh_client
include_recipe "#{cookbook_name}::init"

# We need hashdiff to compute the diff between current and needed rules
chef_gem 'hashdiff' do
  compile_time true
end
require 'hashdiff'

# Get ovh information filled by init recipe
ovh_client = node.run_state['ovh_client']
ovh_ip = node.run_state['ovh_ip']

config = node[cookbook_name]['firewall']
firewall_url = "/ip/#{ovh_ip}%2F32/firewall"
fw_ips = ovh_client.get(firewall_url)

# Create firewall for this server if it is not already created
unless fw_ips.include? ovh_ip
  # We have to do it right now (at compile) if we want to converge in one run
  create = ruby_block "Create firewall on #{ovh_ip}" do
    block do
      ovh_client.post(firewall_url, 'ipOnFirewall' => ovh_ip)
    end
    action :nothing
  end
  create.run_action(:run)
  fw_ips << ovh_ip

  ruby_block "Waiting for firewall creation on #{ovh_ip}" do
    block do
      (1..10).each do |try|
        break if ovh_client.get(firewall_url).include?(ovh_ip)
        sleep(try)
      end
    end
    action :run
  end
end

# For each ip configured
config.each do |fw_ip, ip_config| # rubocop:disable Metrics/BlockLength
  # Configure default
  ip_config = ip_config.dup || {}
  ip_config['enable'] = true if ip_config['enable'].nil?
  fw_ip = ovh_ip if fw_ip == 'primary'

  # Check fw_ip validity
  unless fw_ips.include? fw_ip
    raise "#{fw_ip} is not a valid ip for #{ovh_ip} firewall"
  end

  # Enable or disable the firewall depending of the current state 'enabled'
  ip_info = ovh_client.get("#{firewall_url}/#{fw_ip}")
  ruby_block "Enable/Disable firewall on #{fw_ip}" do
    block do
      ovh_client.put(
        "/ip/#{ovh_ip}%2F32/firewall/#{fw_ip}",
        'enabled' => ip_config['enable']
      )
    end
    action :run
    only_if do
      ip_info['state'] == 'ok' &&
        ip_config['enable'] != ip_info['enabled']
    end
  end

  next unless ip_config['enable']

  # Get current rules applied on the firewall
  current = ovh_client.get("#{firewall_url}/#{fw_ip}/rule")
  current = current.map do |i|
    current_i = ovh_client.get("#{firewall_url}/#{fw_ip}/rule/#{i}")
    current_i['tcpOption'] = {
      'option' => current_i['tcpOption'],
      'fragments' => current_i['fragments']
    }
    current_i.delete 'fragments'
    # Clean port configuration (API return 'eq 22' instead of 22)
    %w[destinationPort sourcePort].each do |key|
      unless current_i[key].nil?
        current_i[key] = current_i[key].gsub('eq ', '').to_i
      end
    end
    { i.to_s => current_i }
  end.reduce({}, :merge)

  # Make the diff between current and needed rules
  expected_rules = ip_config['rules'].to_hash
  expected_rules.each_pair do |_sequence, rule|
    %w[destinationPort sourcePort].each do |key| # Convert ports to integer
      rule[key] = rule[key].to_i unless rule[key].nil?
    end
  end
  diff_current_config = ::HashDiff.diff(current, expected_rules)

  # Solve the diff, may take two runs when a rule is modified
  diff_current_config.each do |todo, seq, body|
    case todo

    when '+'
      body['sequence'] = seq.to_i
      ruby_block "Add rule #{seq} on #{fw_ip}" do
        block { ovh_client.post("#{firewall_url}/#{fw_ip}/rule", body) }
        action :run
      end

    when '-'
      next if seq.include? '.'
      next unless body['state'] == 'ok'
      ruby_block "Remove rule #{seq} on #{fw_ip}" do
        block { ovh_client.delete("#{firewall_url}/#{fw_ip}/rule/#{seq}") }
        action :run
      end

    when '~'
      seq = seq.split('.').first
      ruby_block "Remove rule #{seq} on #{fw_ip}" do
        block { ovh_client.delete("#{firewall_url}/#{fw_ip}/rule/#{seq}") }
        action :run
      end

    else
      raise 'Invalid "todo" action for HashDiff'
    end
  end
end
