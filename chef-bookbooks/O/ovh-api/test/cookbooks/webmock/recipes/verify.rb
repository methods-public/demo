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

# Write all executed requests to a file so we will verify its content
# with serverspec in verify phase
ruby_block 'store executed requests' do
  block do
    sigs = {}
    signatures = WebMock::RequestRegistry.instance.requested_signatures
    signatures.each { |request, count| sigs[request] = count }

    File.write('/tmp/executed_requests', Marshal.dump(sigs))
  end
end

# Same with Ohai OVH values
file '/tmp/ohai-ovh' do
  content node['ovh'].to_s
end
