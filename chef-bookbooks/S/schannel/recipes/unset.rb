#
# Author:: pdeprey (<pdeprey@gmail.com>)
# Cookbook:: schannel
# Recipe:: unset
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
# this recipe restore the windows default configuration of SCHANNEL registry values.

return unless platform? 'windows'

# constant variable
regdir = 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL'

# deleting all registry path on SCHANNEL
%w(KeyExchangeAlgorithms Hashes Ciphers Protocols).each do |pathkey|
  registry_key "#{regdir}\\#{pathkey}" do
    action    :delete_key
    recursive true
  end
end

# recreate default SSL 2.0 Client key
registry_key "#{regdir}\\Protocols\\SSL 2.0\\Client" do
  action    :create
  recursive true
  values    [{ name: 'DisabledByDefault', type: :dword, data: 1 }]
end

# reset order value
registry_key 'HKLM\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002' do
  action    :delete
  recursive true
  values    [{ name: 'Functions', type: :string, data: '' }]
end
