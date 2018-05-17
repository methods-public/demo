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

describe 'Attributes not replaced (default non-whitelisted)' do
  it 'sym_replace should not be replaced' do
    expect(dynamic['sym_replace']).to eq('node[:fqdn]')
  end

  it 'hash_replace should not have keys being replaced' do
    expect(dynamic['hash_replace']).to eq(
      'node[\'ipaddress\']' => { 'node[\'fqdn\']' => 'deep' }
    )
  end

  it 'array_replace should not be replaced' do
    expect(dynamic['array_replace']).to eq(['node[\'fqdn\']', 'misc'])
  end
end
