#
# Cookbook Name:: netdevops
# Atributes:: opencontrail
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

# NOTES:
#
# Install a minimum-viable OpenContrail + Contrail API footprint.
#
# neutron-plugin-contrail installs many dependencies into the *system*
# Python, including python-openstack clients, like Nova, Neutron, etc.
#
# Some of these are also installed into the default .pyenv for the default
# user (vagrant).  This ensures that bleeding-edge OpenStack development
# and/or pip package installs don't mess with this environment.  It's
# recommended to only use the system OpenStack for Contrail at this time.

default['netdevops']['package']['opencontrail'] = %w( contrail-go-api-dev
                                                      contrail-go-cli
                                                      contrail-lib
                                                      neutron-plugin-contrail
                                                      python-contrail )
