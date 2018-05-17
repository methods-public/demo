# Copyright 2015 David Petzel
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

default['yum']['mesosphere-source'].tap do |source|
  source['repositoryid'] = 'mesosphere-source'
  source['managed'] = true
  source['enabled'] = false
  source['gpgcheck'] = true

  if node['platform_version'].to_i == 6
    source['description'] = 'Mesosphere Packages for EL 6 - $basearch - Source'
    source['baseurl'] = 'http://repos.mesosphere.io/el/6/SRPMS/'
    source['gpgkey'] = 'http://repos.mesosphere.io/el/RPM-GPG-KEY-mesosphere'
  end
end
