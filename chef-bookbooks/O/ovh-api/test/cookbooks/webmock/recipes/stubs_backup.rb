#
# Copyright (c) 2017 Make.org
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

# Include init to load all dependencies
include_recipe "#{cookbook_name}::stubs_init"

# Useful variables
url = node['ovh-api']['api-url']
service_name = 'default-ovh.kitchen'
addresses = node['network']['interfaces']['eth0']['addresses']
backup_url = "#{url}/dedicated/server/#{service_name}/features/backupFTP"
ip = addresses.select { |_addr, info| info['family'] == 'inet' }.keys.first

# Stubs definition for backup recipe
stub_request(:get, backup_url).to_return(
  body: <<-JSON,
   {
    "message": "The requested object (backupFTP) does not exist"
   }
  JSON
  status: 404
).times(3).then.to_return(
  body: <<-JSON,
  {
    "quota": {
      "unit": "GB",
      "value": 500
    },
    "usage": null,
    "ftpBackupName": "ftpback-test-1.ovh.net",
    "type": "included",
    "readOnlyDate": null
  }
  JSON
  status: 200
)

stub_request(:post, backup_url).to_return(
  body: <<-JSON,
  {
    "taskId": "75466930",
    "function": "createBackupFTP",
    "lastUpdate": "2017-10-17T14:30:04+02:00",
    "comment": "Start backup FTP installation",
    "status": "init",
    "startDate": "2017-10-17T14:30:04+02:00",
    "doneDate": null
  }
  JSON
  status: 200
)

stub_request(:get, "#{backup_url}/access").to_return(
  body: <<-JSON,
  ["#{ip}/32"]
  JSON
  status: 200
)

stub_request(:get, "#{backup_url}/access/#{ip}%2F32").to_return(
  body: <<-JSON,
  {
    "ipBlock": "#{ip}/32",
    "ftp": true,
    "lastUpdate": "2017-10-17T14:32:04+02:00",
    "nfs": false,
    "isApplied": true,
    "cifs": false
  }
  JSON
  status: 200
)

stub_request(:put, "#{backup_url}/access/#{ip}%2F32")
  .with(body: '{"cifs":true,"ftp":true,"nfs":true}')
  .to_return(body: 'null', status: 200)
