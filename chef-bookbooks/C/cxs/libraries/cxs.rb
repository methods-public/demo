# encoding: UTF-8
#
# Cookbook Name:: cxs
# Libraries:: cxs
# Author:: Vassilis Aretakis (<vassilis@aretakis.eu>)
# Copyright:: Copyright (c) 2017 Vassilis Aretakis
# License:: Apache License, Version 2.0
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
require 'net/http'

class Chef::Resource::CXSLicense
  def self.valid? (uri = 'http://license.configserver.com/cgi-bin/cxs/check.cgi')
    return true unless Net::HTTP.get_response(URI(uri)).body.include?('Invalid license')
    return false
  end
end
