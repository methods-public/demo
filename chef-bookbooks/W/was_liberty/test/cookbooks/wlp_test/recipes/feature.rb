# Cookbook Name:: wlp_test
# Attributes:: default
#
# (C) Copyright IBM Corporation 2016.
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

include_recipe "wlp::default"


wlp_download_feature "collective download" do
  name "clusterMember-1.0 explore-1.0"
  directory "/opt/was/liberty/features"
  accept_license true
end

wlp_install_feature "Liberty" do
  name "collectiveMember-1.0"
  accept_license true
end

wlp_install_feature "LARS" do
  name "explore-1.0"
  accept_license true
end


wlp_install_feature "Local" do
  name "clusterMember-1.0"
  accept_license true
end
