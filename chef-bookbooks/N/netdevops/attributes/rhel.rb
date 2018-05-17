#
# Cookbook Name:: netdevops
# Atributes:: rhel
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

# man is somehow missing from default centos6
default['netdevops']['package']['rhel'] = %w( device-mapper-libs
                                              gdbm-devel
                                              git
                                              iotop
                                              iptraf
                                              libffi-devel
                                              libvirt
                                              libvirt-client
                                              libxml2-devel
                                              libxslt-devel
                                              libyaml-devel
                                              man
                                              mlocate
                                              nc
                                              ncurses-devel
                                              nmap
                                              openssl-devel
                                              python-devel
                                              python-setuptools
                                              socat
                                              sysstat
                                              tcpdump
                                              telnet
                                              traceroute
                                              unzip
                                              wget
                                              zlib-devel )

# tmux in epel in 6, base in 7
# gets installed later, and doesn't matter at that point
default['netdevops']['package']['epel'] = %w( atop
                                              bash-completion
                                              cowsay
                                              hping3
                                              htop
                                              iftop
                                              nodejs
                                              npm
                                              tmux )

default['netdevops']['vagrant']['rhel']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/'
default['netdevops']['vagrant']['rhel']['package'] = 'vagrant_1.7.2_x86_64.rpm'
default['netdevops']['vagrant']['rhel']['checksum'] = '683d9926922685adfb456605ef6becaa811b87f18f54faf7c19abc4888636617'
