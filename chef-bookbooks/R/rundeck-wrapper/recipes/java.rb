#
# Copyright (c) 2017 Make.org
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

# Java is needed. We may install it with package if we do not want to use
# java cookbook
unless node['rundeck_server']['install_java']
  java_package = node[cookbook_name]['java'][node['platform']]
  package_retries = node[cookbook_name]['package_retries']

  package "#{cookbook_name}:java" do
    package_name java_package
    retries package_retries unless package_retries.nil?
    not_if { java_package.to_s.empty? }
  end
end
