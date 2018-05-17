#
# Cookbook Name:: gnugpg
#
# Copyright (C) 2017 Rodel Manalo Talampas
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

default['gnugpg']['installer']['windos'] = 'gpg4win-3.0.0.exe'
default['gnugpg']['installer']['debian'] = ''
default['gnugpg']['installer']['centos'] = ''

default['gnugpg']['temp']['directory'] = 'c:\\tmp'

default['gnugpg']['key']['public'] = 'changeme'
default['gnugpg']['key']['private'] = 'changeme'
default['gnugpg']['key']['passphrase'] = 'changeme'

default['gnugpg']['keys']['file'] = []
