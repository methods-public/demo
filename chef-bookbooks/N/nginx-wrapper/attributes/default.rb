#
# Copyright (c) 2016-2017 Sam4Mobile
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

cookbook_name = 'nginx-wrapper'

# Certs to fetch from encrypted data bag items
default[cookbook_name]['data_bag']['name'] = nil
default[cookbook_name]['data_bag']['items'] = nil

# Define where SSL certs are deployed
default[cookbook_name]['ssl_certs_dir'] = '/etc/nginx/ssl'

# Define ssl confis to deploy (using certificate_manage resource from
# certificate cookbook
default[cookbook_name]['ssl_configs'] = []

# Configure retries for the package resources, default = global default (0)
# (mostly used for test purpose)
default[cookbook_name]['package_retries'] = nil
