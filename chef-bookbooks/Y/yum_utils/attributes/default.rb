#
# Cookbook Name:: yum_utils
# Attributes:: default
#
# Copyright 2013-2017, whitestar
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

default['yum_utils']['repos']['CentOS-Base'] = {
  'mirrorlist_ctx' => '', # default: inactive
  #'mirrorlist_ctx' => 'http://mirrorlist.centos.org',
  'baseurl_ctx' => '',  # default: inactive
  #'baseurl_ctx' => 'http://mirror.centos.org/centos',
  #'baseurl_ctx' => 'http://ftp.grid.example.com/centos',
  #'baseurl_ctx' => 'http://localhost/centos',
  'gpgkey' => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
}
default['yum_utils']['repos']['epel'] = {
  'mirrorlist_ctx' => '', # default: inactive
  #'mirrorlist_ctx' => 'http://mirrors.fedoraproject.org',
  'baseurl_ctx' => '',  # default: inactive
  #'baseurl_ctx' => 'http://ftp.grid.example.com/fedora/epel',
  #'baseurl_ctx' => 'http://localhost/fedora/epel',
  'gpgkey' => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6',
}

# Repository mirroring by rsync
default['yum_utils']['mirror']['user'] = 'yum-mirror'
default['yum_utils']['mirror']['cron_period'] = '#0 2	* * *'  # default: inactive
default['yum_utils']['mirror']['base_path'] = '/var/spool/yum-mirror'
default['yum_utils']['mirror']['rsync_sources'] = [
=begin
  # default: inactive
  # examples
  # CentOS
  # http://www.centos.org/modules/tinycontent/index.php?id=30
  {
    'url' => 'rsync://ftp.riken.jp/centos/',
    'rsync_opts' => '-avSH --stats --partial --delete --safe-links --exclude /[1-5]*/ --exclude /6.[0-3]/ --exclude local* --exclude isos --exclude ppc*',
    'http_alias' => '/centos'
  },
  # EPEL
  # http://mirrors.fedoraproject.org/publiclist/EPEL/
  {
    'url' => 'rsync://ftp.riken.jp/fedora/epel/',
    'rsync_opts' => '-avSH --stats --partial --delete --safe-links --exclude /[1-5]*/ --exclude local* --exclude isos --exclude ppc*',
    'http_alias' => '/fedora/epel'
  },
=end
]

# Repository mirroring by reposync
default['yum_utils']['reposync_mirror']['user'] = 'yum-mirror'
default['yum_utils']['reposync_mirror']['cron_period'] = '#0 3   * * *'  # default: inactive
default['yum_utils']['reposync_mirror']['base_path'] = '/var/spool/yum-reposync-mirror'
default['yum_utils']['reposync_mirror']['yum_conf'] = value_for_platform_family(
  'debian' => '/etc/yum/yum.conf',
  'rhel' => '/etc/yum.conf'
)
default['yum_utils']['reposync_mirror']['repos_dir'] = value_for_platform_family(
  'debian' => '/etc/yum/repos.d',
  'rhel' => '/etc/yum.repos.d'
)
default['yum_utils']['reposync_mirror']['repo_ids'] = []
default['yum_utils']['reposync_mirror']['arch'] = ''
default['yum_utils']['reposync_mirror']['url_alias_with_authority_part'] = true
