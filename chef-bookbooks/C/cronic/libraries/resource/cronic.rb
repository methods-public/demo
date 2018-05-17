# frozen_string_literal: true

#
# Cookbook:: cronic
# Library:: resource/cronic
#
# Copyright:: 2013, Socrata, Inc.
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

require 'chef/resource/cron'

class Chef
  class Resource
    # A custom resource for managing Cronic-run cron jobs. Take the core cron
    # resource and coerce its command property to run the jobs via Cronic.
    class Cronic < Cron
      property :command,
               String,
               coerce: proc { |v| "/usr/local/sbin/cronic #{v}" }
    end
  end
end
