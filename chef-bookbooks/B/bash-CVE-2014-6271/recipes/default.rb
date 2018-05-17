#
# Cookbook Name:: bash-CVE-2014-6271
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

node['bash-CVE-2014-6271']['bashes'].each do |current_bash|
  execute "CVE-2014-6271 test of #{current_bash}" do
    only_if "test -x #{current_bash}"
    command "env x='() { :;}; echo Your bash is very likely vulnerable if this recipe failed for the reason that this chef execute resource block exited 0. Non-vulnerable bash will exit 1' bash -c 'echo this is a test' | grep 'Your bash' > /dev/null 2>&1"
    returns [1] # The grep should fail and exit with 1
  end
end
