#
# Author:: pdeprey (<pdeprey@gmail.com>)
# Cookbook:: schannel
# Recipe:: default
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
# this recipe configure the secure channel windows registry values.

return unless platform? 'windows'

# constant variable
regdir = 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL'

# set the secure cipher suite to the windows registry
registry_key 'HKLM\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002' do
  action     node['schannel']['cipher_order']['secure'] ? :create : :nothing
  recursive  true
  values     [{ name: 'Functions', type: :string, data: node['schannel']['cipher_order']['list'].join(',') }]
end

# event logging set level of debugging
registry_key regdir.to_s do
  action      :create
  recursive   true
  values      [{ name: 'EventLogging', type: :dword, data: node['schannel']['event_logging']['level'] }]
end

# enable/disable the schannel protocols
sclist = node['schannel']['protocols_client_side'] ? %w(Server Client) : %w(Server)
sclist.each do |sc|
  node['schannel']['protocols'].each do |pname, pval|
    registry_key "#{regdir}\\Protocols\\#{registry_name(pname)}\\#{sc}" do
      action     :create
      recursive  true
      values [
        { name: 'DisabledByDefault', type: :dword, data: pval['enable'] ? 0 : 1 },
        { name: 'Enabled',           type: :dword, data: pval['enable'] ? 4_294_967_295 : 0 },
      ]
    end
  end
end

# enable/disable the schannel ciphers
node['schannel']['ciphers'].each do |cname, cval|
  registry_key "#{regdir}\\Ciphers\\#{registry_name(cname)}" do
    action     :create
    recursive  true
    values     [{ name: 'Enabled', type: :dword, data: cval['enable'] ? 4_294_967_295 : 0 }]
  end
end

# enable/disable the schannel hashes
node['schannel']['hashes'].each do |hname, hval|
  registry_key "#{regdir}\\Hashes\\#{registry_name(hname)}" do
    action     :create
    recursive  true
    values     [{ name: 'Enabled', type: :dword, data: hval['enable'] ? 4_294_967_295 : 0 }]
  end
end

# enable/disable the schannel key exchange algorithms
node['schannel']['keyexch'].each do |kname, kval|
  registry_key "#{regdir}\\KeyExchangeAlgorithms\\#{registry_name(kname)}" do
    action     :create
    recursive  true
    values     [{ name: 'Enabled', type: :dword, data: kval['enable'] ? 4_294_967_295 : 0 }]
  end
end
