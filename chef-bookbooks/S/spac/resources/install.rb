# Cookbook Name:: spac
# Resource:: install
#
# Author:: Sander Botman (<sander.botman@gmail.com>)
# Copyright:: 2018 Sander Botman.
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

resource_name :spac

property :name, String, name_property: true # ~FC108 This allows for bare names like spac_install
property :url, String, default: ''
property :version, String, default: ''
property :checksum, String, default: ''
property :owner, String, default: 'root'
property :group, String, default: 'root'
property :mode, String, default: '0700'

action :install do
  if new_resource.version != current_version || new_resource.checksum != current_checksum
    converge_by "spac #{new_resource.version}" do
      spac_service('stop')
      spac_service('uninstall')

      directory spac_path do
        recursive true
      end

      remote_file spac_exe do
        source new_resource.url
        checksum new_resource.checksum
        sensitive true
      end

      spac_service('install')
      spac_service('start')
    end
  end

  service 'spac'

  template spac_config do
    source 'spac_config.erb'
    owner new_resource.owner unless platform_family?('windows')
    group new_resource.group unless platform_family?('windows')
    mode new_resource.mode unless platform_family?('windows')
    notifies :restart, 'service[spac]', :delayed
  end
end

action_class do
  def spac_path
    platform_family?('mac_os_x') ? '/opt/spac' : '/etc/spac'
  end

  def spac_exe
    platform_family?('windows') ? ::File.join(spac_path, 'spac.exe') : ::File.join(spac_path, 'spac')
  end

  def spac_config
    ::File.join(spac_path, 'config.json')
  end

  def spac_service(cmd)
    execute "#{cmd} spac service" do
      command spac_service_command(cmd)
      returns [0, 1] if ['stop', 'uninstall'].include?(cmd)
      only_if current_version if ['stop', 'uninstall'].include?(cmd)
    end
  end

  def spac_service_command(cmd)
    "#{spac_exe} --service #{cmd}"
  end

  def current_version
    current_checksum ? current_version_cmd : nil
  end

  def current_version_cmd
    cmd = shell_out!("\"#{spac_exe}\" --version")
    %r{Version: (\d*\.\d*\.\d[^\/]*)}.match(cmd.stdout)[1].chomp
  end

  def current_checksum
    ::File.exist?(spac_exe) ? Digest::SHA256.file(spac_exe).hexdigest : nil
  end
end


