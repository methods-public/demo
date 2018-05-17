# encoding: UTF-8
#
# Cookbook Name:: cxs
# Attributes:: ignore
# Author:: Vassilis Aretakis (<vassilis@aretakis.eu>)
# Copyright:: Copyright (c) 2017 Vassilis Aretakis
# License:: Apache License, Version 2.0
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

default['cxs']['ignore'] = [
  [ 'hdir', '/.cagefs' ],
  [ 'file', 'error_log' ],
  [ 'pfile', '\/home\/.*\/public_html\/.*\/error_log$' ],
  [ 'hdir', '/etc' ],
  [ 'hdir', '/mail' ],
  [ 'hdir', '/tmp' ],
  [ 'hdir', '/.cagefs' ],
  [ 'hdir', '/.fantasticodata' ],
  [ 'hdir', '/.rvsitebuilder' ],
  [ 'hdir', '/.sqmaildata' ],
  [ 'hdir', '/.trash' ],
  [ 'hdir', '/.quarantine' ],
  [ 'hdir', '/quarantine_clamavconnector' ],
  [ 'hsym', '/access-logs' ],
  [ 'hfile', '/public_html/cgi-bin/randhtml.cgi' ],
  [ 'hfile', '/public_html/cgi-bin/entropybanner.cgi' ],
  [ 'hfile', '/public_html/cgi-bin/cgiemail' ],
  [ 'hfile', '/public_html/cgi-bin/cgiecho' ],
  [ 'hfile', '/public_html/cgi-bin/cpdownload/cpaneldownacct.cgi' ],
  [ 'hfile', '/public_html/cgi-bin/cpdownload/cpaneldownload.cgi' ],
  [ 'hfile', '/public_html/cgi-bin/cpdownload/cpanelkill.cgi' ],
  [ 'hfile', '/public_html/cgi-bin/cpdownload/cpanelwrap.c' ],
  [ 'hfile', '/public_html/cgi-bin/cpdownload/cpanelwrap.cgi' ],
  [ 'pfile', '^/tmp/clamav-.*' ],
  [ 'pdir', '^/tmp/clamav-.*' ],
  [ 'pfile', '^/tmp/cxs_.*' ],
  [ 'md5sum', 'f3c8aaf882d1ed25a7f5fe7fd2ee4d9d' ],
  [ 'pdir', '.*/cache/smarty/.*' ]
]
