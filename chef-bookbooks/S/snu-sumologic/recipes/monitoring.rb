# frozen_string_literal: true

#
# Cookbook Name:: snu-sumologic
# Recipe:: monitoring
#
# Copyright (C) 2014-2018, Socrata, Inc.
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

include_recipe 'sensu'
include_recipe '::installation'

group 'Make the sensu user a member of the sumologic_collector group' do
  group_name 'sumologic_collector'
  members node['sensu']['user']
  append true
  action :modify
end

# TODO: The snu-sensu cookbook doesn't exist yet but, when it does, it should
# support Sensu check resources that look something like this:
#
# snu_sensu_process_check 'sumo_logic_collector_processes' do
#   warn_min 2
#   critical_min 2
#   warn_max 2
#   critical_max 2
#   # interval 300 # The default? TBD
#   # strikes 3 # The default? TBD
#   opsdoc '???'
#   business_hours true
# end
#
# snu_sensu_file_mtime_check 'sumo_logic_log_file' do
#   file '/opt/SumoCollector/logs/collector.log'
#   warn 300
#   critical 300
#   # interval 300 # The default? TBD
#   # strikes 3 # The default? TBD
#   opsdoc '???'
#   business_hours true
# end
