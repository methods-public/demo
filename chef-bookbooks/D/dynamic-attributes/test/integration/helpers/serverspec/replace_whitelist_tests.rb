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
describe 'Attributes replaced (whitelisted)' do
  it 'revrec_replace should be fqdn' do
    expect(dynamic['revrec_replace']).to eq(attributes['fqdn'])
  end

  it 'complex_replace should be correctly handled' do
    expect(dynamic['complex_replace']).to eq(
      [
        {
          attributes['fqdn'] => attributes['fqdn'],
          'a' => { 'b' => [attributes['ipaddress']] }
        },
        attributes['ipaddress']
      ]
    )
  end

  it 'nil_replace should not be replaced' do
    expect(dynamic['nil_replace']).to eq('node[\'dynamic\'][\'doesnotexist\']')
  end

  it 'override.fqdn_replace should be fqdn' do
    expect(override['fqdn_replace']).to eq(attributes['fqdn'])
  end

  it 'override.rec_replace should be like array_replace' do
    expect(override['rec_replace']).to eq(dynamic['array_replace'])
  end

  it 'mixed should be replaced with first part eq to fqdn' do
    expect(dynamic['mixed'].first).to eq(attributes['fqdn'])
  end
end
