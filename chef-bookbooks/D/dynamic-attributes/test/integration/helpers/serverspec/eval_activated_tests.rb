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

# rubocop:disable Security/MarshalLoad
attributes = ::Marshal.load(File.read('/root/attributes'))
dynamic = attributes['dynamic']
override = dynamic['override']

# rubocop:disable Metrics/BlockLength
describe 'Attributes evaluated (activated)' do
  it 'fqdn_eval should be fqdn' do
    expect(dynamic['fqdn_eval']).to eq(attributes['fqdn'])
  end

  it 'op_eval should be "1+1=2"' do
    expect(dynamic['op_eval']).to eq('1+1=2')
  end

  it 'hash_eval should have keys being evaluated' do
    expect(dynamic['hash_eval']).to eq(
      'eth2' => {
        "#{attributes['fqdn']}-#{attributes['ipaddress']}" => 'deep'
      }
    )
  end

  it 'complex_eval should be correctly handled' do
    expect(dynamic['complex_eval']).to eq(
      [
        {
          attributes['fqdn'] => '1+1=2',
          'a' => { 'b' => [":#{attributes['fqdn']}"] }
        },
        "sym:#{attributes['ipaddress']}"
      ]
    )
  end

  it 'revrec_eval should be the old value of override.recursive_eval' do
    expect(dynamic['revrec_eval']).to eq('#{node[\'dynamic\'][\'op_eval\']}')
  end

  it 'override.composition_eval should be test-fqdn' do
    expect(override['composition_eval']).to eq("test-#{attributes['fqdn']}")
  end

  it 'override.array_eval should be [fqdn-ipaddress, 2]' do
    expect(override['array_eval']).to eq(
      ["#{attributes['fqdn']}-#{attributes['ipaddress']}", '2']
    )
  end

  it 'override.rec_eval should be like op_eval' do
    expect(override['rec_eval']).to eq(dynamic['op_eval'])
  end

  it 'mixed should be evaluated with last part eq to :fqdn' do
    expect(dynamic['mixed'].last).to eq(":#{attributes['fqdn']}")
  end
end

require 'eval_dangerous_tests'
