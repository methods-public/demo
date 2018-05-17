#
# Cookbook Name:: opsview
# Attributes:: check_oracle
#
# Copyright 2015, Biola University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE_2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['opsview']['check_oracle']['dbd_oracle_version'] = "1.74"
default['opsview']['check_oracle']['dbd_oracle_url'] = "http://search.cpan.org/CPAN/authors/id/P/PY/PYTHIAN/DBD-Oracle-1.74.tar.gz"
default['opsview']['check_oracle']['dbd_oracle_checksum'] = "4a676ff28193303ea92f4660cd4889063480837a2c2a59a43744ac1e74b795d4"

default['opsview']['check_oracle']['plugin_version'] = "1.9.4.4"
default['opsview']['check_oracle']['plugin_url'] = "http://labs.consol.de/download/shinken-nagios-plugins/check_oracle_health-1.9.4.4.tar.gz"
default['opsview']['check_oracle']['plugin_checksum'] = "e63a1ad58d67cf8c9476d3faf0a7581a189b7075e086778f6f2ac7957e8ef935"

default['opsview']['check_oracle']['statefiles_dir'] = "/tmp/check_oracle_health"