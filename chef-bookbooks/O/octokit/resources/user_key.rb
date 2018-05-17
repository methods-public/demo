#!/usr/bin/env ruby
# coding: utf-8
# frozen_string_literal: true

#
# Cookbook:: octokit
# Custom Resource:: github_user_key
#
# Author:: Basil Peace <grv87@yandex.ru>
#
# Copyright:: © 2017  Basil Peace
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

require 'octokit'

resource_name :github_user_key

property :login, String
property :password, String, required: true, sensitive: true
property :title, String, name_property: true, required: true
property :key, String, required: true, identity: true

property :id, Integer, desired_state: true

default_action :create_or_replace

def client
  @client ||= ::Octokit::Client.new(login: login, password: password)
end

load_current_value do |desired|
  login desired.login
  password desired.password
  client.keys.each do |k|
    next if k['key'].split(' ') != desired.key.chomp.split(' ')[0..1]
    id k['id']
    title k['title']
    key desired.key
    return
  end
  current_value_does_not_exist!
end

action :create do
  converge_if_changed do
    new_resource.client.add_key title, key
  end
end

action :remove do
  if current_resource
    current_resource.client.remove_key current_resource.id
  else
    Chef::Log.info "#{current_resource} github user key doesn't exist, skipping"
  end
end

action :create_or_replace do
  converge_if_changed do
    run_action :remove
    run_action :create
  end
end
