#!/usr/bin/env ruby
# coding: utf-8
# frozen_string_literal: true

#
# Cookbook:: octokit
# Metadata
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

name             'octokit'
maintainer       'Basil Peace'
maintainer_email 'grv87@yandex.ru'
license          'Apache-2.0'
description      'Configures Github resources using Octokit toolkit'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
issues_url       'https://github.com/fidata/cookbook-octokit/issues'
source_url       'https://github.com/fidata/cookbook-octokit'
supports         'ubuntu'
supports         'debian'
supports         'windows'
supports         'macosx'
chef_version     '>= 12.5' if respond_to?(:chef_version)
gem              'octokit'
