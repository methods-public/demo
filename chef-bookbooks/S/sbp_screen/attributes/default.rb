#
# Cookbook Name:: sbp_screen
# Attribute:: default
#
# Copyright 2013, Schuberg Philis
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

default['screen']['tunables']['termcap_xterm']     = 'is=\E[r\E[m\E[2J\E[H\E[?7h\E[?1;4;6l'
default['screen']['tunables']['terminfo_xterm']    = 'is=\E[r\E[m\E[2J\E[H\E[?7h\E[?1;4;6l'
default['screen']['tunables']['hardstatus']        = 'alwayslastline'
default['screen']['tunables']['hardstatus_string'] = '%{= kG}[ %{G}%H %{g}][%= %{= kw}%?%-Lw%?%{r} (%{W}%n*%f%t%?(%u)%?%{r})%{w}%?%+Lw%?%?%= %{g}][%{B} %d/%m %{W}%c %{g}]'
default['screen']['tunables']['vbell']             = 'off'
