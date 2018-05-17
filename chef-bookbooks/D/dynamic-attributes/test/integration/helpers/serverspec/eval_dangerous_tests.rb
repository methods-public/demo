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
dynamic2 = attributes['dynamic-2']

describe 'Attributes that should not be modified with any role' do
  it 'dangerous_eval should not be evaluated' do
    expect(dynamic2['dangerous_eval']).to eq('#{`cat /etc/shadow`}')
  end

  it 'string_eval should be strictly identical' do
    expect(dynamic['string_eval']).to eq("\"I'm a string\"")
  end
end
