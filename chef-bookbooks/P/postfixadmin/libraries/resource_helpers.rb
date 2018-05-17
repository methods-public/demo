# encoding: UTF-8
#
# Cookbook Name:: postfixadmin
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Library:: resource_helpers
# Copyright:: Copyright (c) 2017 Xabier de Zuazo
# Copyright:: Copyright (c) 2013 Onddo Labs, SL.
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

module PostfixadminCookbook
  # Helper methods to be included in Chef Custom Resources.
  module ResourceHelpers
    def default_ssl
      node['postfixadmin']['ssl'] ? true : false
    end

    def default_port
      node['postfixadmin']['port'] || (default_ssl ? 443 : 80)
    end
  end
end
