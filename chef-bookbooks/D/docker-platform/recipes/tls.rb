#
# Copyright (c) 2016-2017 Sam4Mobile, 2017-2018 Make.org
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

unless node[cookbook_name]['data_bag']['item'].nil?
  # Init tls options to be passed to config recipe by using run_state
  tls_options = {
    'hosts' => [
      "tcp://0.0.0.0:#{node[cookbook_name]['port']}",
      'unix:///var/run/docker.sock'
    ],
    'tlsverify' => true
  }

  # Create config dir for root which will contains the certs
  # In /root because docker use it by default
  certs_dir = node[cookbook_name]['certs_dir']
  directory "tls:#{certs_dir}" do
    path certs_dir
    recursive true
  end

  db_name = node[cookbook_name]['data_bag']['name']
  db_item = node[cookbook_name]['data_bag']['item']

  # Get ca, cert and key from data bag item
  %w[ca cert key].each do |type|
    type_opt = type == 'ca' ? 'cacert' : type

    cert_path = "#{certs_dir}/#{type}.pem"

    file cert_path do
      content data_bag_item(db_name, db_item)[type]
      mode mode '0600'
    end

    tls_options["tls#{type_opt}"] = cert_path
  end

  # Set tls_options in run_state to get & set them in config recipe
  node.run_state[cookbook_name] ||= {}
  config = node.run_state[cookbook_name]['config'] || {}
  node.run_state[cookbook_name]['config'] = config.merge(tls_options)
end
