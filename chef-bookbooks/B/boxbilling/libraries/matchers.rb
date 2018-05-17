# encoding: UTF-8
#
# Cookbook Name:: boxbilling
# Library:: matchers
# Author:: Raul Rodriguez (<raul@onddo.com>)
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL.
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

if defined?(ChefSpec)

  if ChefSpec.respond_to?(:define_matcher)
    # ChefSpec >= 4.1
    ChefSpec.define_matcher :boxbilling_api
  elsif defined?(ChefSpec::Runner) &&
        ChefSpec::Runner.respond_to?(:define_runner_method)
    # ChefSpec < 4.1
    ChefSpec::Runner.define_runner_method :boxbilling_api
  end

  def request_boxbilling_api(path)
    ChefSpec::Matchers::ResourceMatcher.new(:boxbilling_api, :request, path)
  end

  def create_boxbilling_api(path)
    ChefSpec::Matchers::ResourceMatcher.new(:boxbilling_api, :create, path)
  end

  def update_boxbilling_api(path)
    ChefSpec::Matchers::ResourceMatcher.new(:boxbilling_api, :update, path)
  end

  def delete_boxbilling_api(path)
    ChefSpec::Matchers::ResourceMatcher.new(:boxbilling_api, :delete, path)
  end

end
