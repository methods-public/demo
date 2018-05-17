#
# Copyright (c) 2015-2016 Sam4Mobile
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

# Configuration for network-interface
default['dhcp-wrapper']['network-interface'] = []

# Path where to put network configuration
default['dhcp-wrapper']['config-path'] = '/etc/sysconfig/network-scripts'

# Add those routes after network initialization
default['dhcp-wrapper']['routes'] = []

# Specific configuration depending on status (client or server)
default['dhcp-wrapper']['client-config'] = {}
default['dhcp-wrapper']['server-config'] = {}
