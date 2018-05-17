#
# Cookbook:: sbp_messageanalyzer
# Attribute:: default
#
# Copyright:: 2015-2017, Schuberg Philis
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

#<> Configures the version of .Net Framework to install
default['ms_dotnet']['v4']['version'] = '4.5'

#<> Download URL for Message Analyzer
default['sbp_messageanalyzer']['url'] = 'http://download.microsoft.com/download/2/8/3/283DE38A-5164-49DB-9883-9D1CC432174D/MessageAnalyzer64.msi'
#<> SHA256 checksum of install file
default['sbp_messageanalyzer']['checksum'] = '9bc60aa8f823b9dd27943a78f64fd74b676b13d45eb546801bc487f565b7c1ea'
