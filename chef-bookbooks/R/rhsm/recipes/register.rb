#
# Cookbook Name:: rhsm
# Recipe:: register
#
# Copyright (C) 2014 RightScale, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node['platform'] == 'redhat'

  include_recipe 'chef-sugar::default'

  rhsm_username = node['rhsm']['username']
  rhsm_password = node['rhsm']['password']

  additional_repos = node['rhsm']['additional_repos']

  unless rhsm_username && rhsm_password
    raise 'rhsm/username and rhsm/password attributes should be set'
  end

  # If system is currently unregistered, register it.
  compile_time do
    execute 'register instance with redhat.com' do
      command "subscription-manager register --username #{rhsm_username} --password #{rhsm_password} --auto-attach"
      not_if 'subscription-manager identity'
    end
  end

  unless additional_repos.empty?
    additional_repos.each do |repo|
      compile_time do
        execute 'enabling additional repo' do
          command "subscription-manager repos --enable=#{repo}"
        end
      end
    end
  end

else
  log 'Not RHEL - skipping redhat.com registration'
end
