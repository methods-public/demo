#
# Cookbook Name:: netdevops
# Atributes:: debian
#
# Copyright 2015 John Deatherage
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

default['netdevops']['package']['debian'] = %w( atom
                                                atop
                                                cowsay
                                                git
                                                hping3
                                                htop
                                                iftop
                                                iotop
                                                iptraf
                                                libffi-dev
                                                libgdbm-dev
                                                libncurses5-dev
                                                libreadline-dev
                                                libssl-dev
                                                libxml2-dev
                                                libxslt1-dev
                                                libyaml-dev
                                                netcat
                                                nmap
                                                node
                                                python-dev
                                                python-setuptools
                                                socat
                                                sysstat
                                                tmux
                                                traceroute
                                                unzip
                                                vim
                                                wget
                                                zlib1g-dev )

default['netdevops']['vagrant']['debian']['package'] = 'vagrant_1.7.2_x86_64.deb'
default['netdevops']['vagrant']['debian']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/'
default['netdevops']['vagrant']['debian']['checksum'] = '9d7f1c587134011e2d5429eb21b6c0e95487f52e6d6d47c03ecc82cbeee73968'
