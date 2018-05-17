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
describe 'Attributes not evaluated (not activated)' do
  it 'fqdn_eval should not be evaluated' do
    expect(dynamic['fqdn_eval']).to eq('#{node[\'fqdn\']}')
  end

  it 'op_eval should not be evaluated"' do
    expect(dynamic['op_eval']).to eq('1+1=#{1+1}')
  end

  it 'hash_eval should not have keys being evaluated' do
    expect(dynamic['hash_eval']).to eq(
      'eth#{1+1}' => { '#{node[\'fqdn\']}-#{node[\'ipaddress\']}' => 'deep' }
    )
  end

  it 'complex_eval should not be evaluated' do
    expect(dynamic['complex_eval']).to eq(
      [
        {
          '#{node[\'fqdn\']}' => '1+1=#{1+1}',
          'a' => { 'b' => [':#{node[\'fqdn\']}'] }
        },
        'sym:#{node[:ipaddress]}'
      ]
    )
  end

  it 'revrec_eval should not be evaluated' do
    expect(dynamic['revrec_eval']).to eq(
      '#{node[\'dynamic\'][\'override\'][\'rec_eval\']}'
    )
  end

  it 'override.composition_eval should not be evaluated' do
    expect(override['composition_eval']).to eq('test-#{node[\'fqdn\']}')
  end

  it 'override.array_eval should not be evaluated' do
    expect(override['array_eval']).to eq(
      ['#{node[\'fqdn\']}-#{node[\'ipaddress\']}', '#{1+1}']
    )
  end

  it 'override.rec_eval should not be evaluated' do
    expect(override['rec_eval']).to eq('#{node[\'dynamic\'][\'op_eval\']}')
  end

  it 'mixed should not be evaluated' do
    expect(dynamic['mixed'].last).to eq(':#{node[\'fqdn\']}')
  end
end

require 'eval_dangerous_tests'
