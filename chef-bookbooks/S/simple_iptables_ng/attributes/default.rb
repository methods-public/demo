#
# Cookbook Name:: simple_iptables_ng
# Attributes:: default
#
# Copyright 2014, Dan Fruehauf
#
# This file is part of simple_iptables_ng.
#
# simple_iptables_ng is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# simple_iptables_ng is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with simple_iptables_ng.  If not, see <http://www.gnu.org/licenses/>.
#

# Entries for simple iptables - see README.md for examples
default['simple_iptables_ng']['entries']   = []

# Maximum rules allowed
default['simple_iptables_ng']['max_rules'] = 1024

# Allow SSH from all, unless specified otherwise
default['simple_iptables_ng']['allow_ssh'] = true
