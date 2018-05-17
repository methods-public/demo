# encoding: UTF-8
#
# Cookbook Name:: filesystem_resize
# Provider:: default
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2015 Onddo Labs, SL.
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

use_inline_resources if self.respond_to?(:use_inline_resources)

def whyrun_supported?
  true
end

action :run do
  fs = FilesystemResizeCookbook::Filesystems.new(new_resource.device)
  if fs.resize?
    converge_by("Create #{new_resource}") do
      fs.resize
    end
  end
end
