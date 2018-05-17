#
# Cookbook Name:: gitlab-grid
# Recipe:: commons
#
# Copyright 2017, whitestar
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

gitlab_rb = node['gitlab-grid']['gitlab.rb']
#override_gitlab_rb = node.override['gitlab-grid']['gitlab.rb']
force_override_gitlab_rb = node.force_override['gitlab-grid']['gitlab.rb']

if node['gitlab-grid']['with_ssl_cert_cookbook']
  ::Chef::Recipe.send(:include, SSLCert::Helper)
  cn = node['gitlab-grid']['ssl_cert']['common_name']
  append_server_ssl_cn(cn)
  include_recipe 'ssl_cert::server_key_pairs'

  # GitLab
  cert_path = server_cert_path(cn)
  key_path = server_key_path(cn)
  force_override_gitlab_rb['external_url'] = gitlab_rb['external_url'].gsub('http://', 'https://')
  force_override_gitlab_rb['nginx']['ssl_certificate'] = cert_path
  force_override_gitlab_rb['nginx']['ssl_certificate_key'] = key_path

  # GitLab Container Registry
  unless gitlab_rb['registry_external_url'].nil?
    force_override_gitlab_rb['registry_external_url'] = gitlab_rb['registry_external_url'].gsub('http://', 'https://')
  end

  reg_cert_path = nil
  reg_key_path = nil
  if node['gitlab-grid']['ssl_cert']['registry']['reuse_gitlab_common_name']
    reg_cert_path = cert_path
    reg_key_path = key_path
  else
    reg_cn = node['gitlab-grid']['ssl_cert']['registry']['common_name']
    append_server_ssl_cn(reg_cn)
    unless reg_cn.nil?
      reg_cert_path = server_cert_path(reg_cn)
      reg_key_path = server_key_path(reg_cn)
    end
  end

  force_override_gitlab_rb['registry_nginx']['ssl_certificate'] = reg_cert_path unless reg_cert_path.nil?
  force_override_gitlab_rb['registry_nginx']['ssl_certificate_key'] = reg_key_path unless reg_key_path.nil?
end
