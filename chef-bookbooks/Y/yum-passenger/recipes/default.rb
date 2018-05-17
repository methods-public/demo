#
# Cookbook Name:: yum-passenger
# Recipe:: default
#
# Copyright (C) 2015 Jason Barnett
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# 'Software'), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

node['yum-passenger']['repositories'].each do |repo|

  if node['yum'][repo]['managed']
    yum_repository repo do
      baseurl node['yum'][repo]['baseurl']
      cost node['yum'][repo]['cost']
      description node['yum'][repo]['description']
      enabled node['yum'][repo]['enabled']
      enablegroups node['yum'][repo]['enablegroups']
      exclude node['yum'][repo]['exclude']
      failovermethod node['yum'][repo]['failovermethod']
      fastestmirror_enabled node['yum'][repo]['fastestmirror_enabled']
      gpgcheck node['yum'][repo]['gpgcheck']
      gpgkey node['yum'][repo]['gpgkey']
      http_caching node['yum'][repo]['http_caching']
      include_config node['yum'][repo]['include_config']
      includepkgs node['yum'][repo]['includepkgs']
      keepalive node['yum'][repo]['keepalive']
      max_retries node['yum'][repo]['max_retries']
      metadata_expire node['yum'][repo]['metadata_expire']
      mirror_expire node['yum'][repo]['mirror_expire']
      mirrorlist node['yum'][repo]['mirrorlist']
      mirrorlist_expire node['yum'][repo]['mirrorlist_expire']
      password node['yum'][repo]['password']
      priority node['yum'][repo]['priority']
      proxy node['yum'][repo]['proxy']
      proxy_username node['yum'][repo]['proxy_username']
      proxy_password node['yum'][repo]['proxy_password']
      report_instanceid node['yum'][repo]['report_instanceid']
      repositoryid node['yum'][repo]['repositoryid']
      repo_gpgcheck node['yum'][repo]['repo_gpgcheck']
      skip_if_unavailable node['yum'][repo]['skip_if_unavailable']
      source node['yum'][repo]['source']
      sslcacert node['yum'][repo]['sslcacert']
      sslclientcert node['yum'][repo]['sslclientcert']
      sslclientkey node['yum'][repo]['sslclientkey']
      sslverify node['yum'][repo]['sslverify']
      timeout node['yum'][repo]['timeout']
      username node['yum'][repo]['username']

      action :create
    end
  end
end
