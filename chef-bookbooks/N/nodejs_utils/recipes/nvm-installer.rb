#
# Cookbook Name:: nodejs_utils
# Recipe:: nvm-installer
#
# Copyright 2017, whitestar
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

doc_url = 'https://github.com/creationix/nvm'

[
  'curl',
].each {|pkg|
  resources(package: pkg) rescue package pkg do
    action :install
  end
}

[
  'nvm_install',
].each {|script|
  template "/usr/local/bin/#{script}" do
    source  "usr/local/bin/#{script}"
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
}

log 'nvm-installer post install message' do
  message <<-"EOM"
Note: You must execute the following command manually.
    See #{doc_url}
    * install n:
      $ nvm_install
      ...
      $ source .bashrc
      $ nvm --version
      0.33.6
    * install the latest LTS Node.js
      $ nvm install --lts
      ...
      $ node -v
      v6.11.4
EOM
end
