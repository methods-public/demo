#
# Copyright (c) 2016-2017 Sam4Mobile, 2017-2018 Make.org
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

require 'socket'

Ohai.plugin(:Ovh) do
  provides 'ovh'

  def general
    info = hint?('ovh-general')
    info['vrack_iface'] =
      case info['primary_iface']
      when 'eth0' then 'eth1'
      when 'eth1' then 'eth0'
      when 'eth2' then 'eth3'
      when 'eth3' then 'eth2'
      else 'undefined'
      end
    info
  end

  def hardware
    hint?('ovh-hardware')
  end

  collect_data(:default) do
    ovh Mash.new
    general.each { |key, value| ovh[key] = value }
    ovh['hardware'] = hardware
  end
end

# TODO: add flavors
