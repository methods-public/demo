#
# Copyright (c) 2017 Make.org
#
# Licensed under the Apache License, Version 2.0 (the "License")
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

# Get OVH information filled by init recipe
ovh_client = node.run_state['ovh_client']
ip = node.run_state['ovh_ip']
service_name = node.run_state['ovh_service_name']
backup_url = "/dedicated/server/#{service_name}/features/backupFTP"

# Get backup info, if error we have to activate it
backup_infos =
  begin
    ovh_client.get(backup_url)
  rescue OVH::RESTError
    # Activate backup for this server if it is not already active
    # We have to do it right now (at compile) if we want to converge in one run
    ruby_block "Activate backup on #{service_name}" do
      block { ovh_client.post(backup_url) }
      action :nothing
    end.run_action(:run)

    ruby_block "Waiting for backup init for #{service_name}" do
      block { ovh_client.get(backup_url) }
      action :nothing
      retries 30
    end.run_action(:run)

    ovh_client.get(backup_url)
  end

# We got hostname to mount CIFS / NFS save it into run_state
node.run_state['backup_hostname'] = backup_infos['ftpBackupName']

# Get access blocks (which IP for which rights like FTP/NFS/CIFS etc.)
accesses = ovh_client.get("#{backup_url}/access")

# What we want (we sort to be deterministic)
wanted_protos = node[cookbook_name]['backup']['protos'].sort.to_h
if accesses.include?("#{ip}/32")
  # Configuration for this server (based on its IP)
  ip_access = ovh_client.get("#{backup_url}/access/#{ip}%2F32")
  # Update if necessary
  ruby_block "Update backup access configuration for #{ip}" do
    block { ovh_client.put("#{backup_url}/access/#{ip}%2F32", wanted_protos) }
    action :nothing
    not_if { wanted_protos <= ip_access }
  end.run_action(:run)
else
  wanted_protos['ipBlock'] = "#{ip}/32"
  ruby_block "Set backup access configuration for #{ip}" do
    block { ovh_client.post("#{backup_url}/access", wanted_protos) }
    action :nothing
  end.run_action(:run)
end
