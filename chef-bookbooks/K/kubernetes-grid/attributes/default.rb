#
# Cookbook Name:: kubernetes-grid
# Attributes:: default
#
# Copyright 2016, whitestar
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

default['kubernetes-grid']['apt_repo'] = {
  'url' => 'http://apt.kubernetes.io/',
  'keyurl' => 'https://packages.cloud.google.com/apt/doc/apt-key.gpg',
  # or
  'keyserver' => nil,
  'recv-keys' => nil,
  'override_apt_line' => '',  # e.g. 'deb http://apt.kubernetes.io/ kubernetes-xenial main'
}
default['kubernetes-grid']['yum_repo'] = {
  'baseurl' => 'http://yum.kubernetes.io/repos/kubernetes-el7-x86_64',
  'gpgcheck' => '1',
  'repo_gpgcheck' => '1',
  'gpgkey' => [
    'https://packages.cloud.google.com/yum/doc/yum-key.gpg',
    'https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg',
  ],
}
default['kubernetes-grid']['docker-engine']['setup'] = true
