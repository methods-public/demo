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

describe 'NXRedirect' do
  it 'is not installed' do
    expect(file('/usr/local/bin/nxredirect')).to_not exist
  end

  it 'does not have a service' do
    txt = 'Unit nxredirect.service could not be found.'
    cmd = 'systemctl status nxredirect'
    expect(command(cmd).stderr).to match(txt)
  end

  it 'is not listening on port 53' do
    expect(port(53)).to_not be_listening
  end
end
