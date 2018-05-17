#
# Copyright (c) 2017-2018 Make.org
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

nodetool = "#{node[cookbook_name]['bin_dir']}/nodetool"
# Create cassandra exporter script and metrics directory
[
  node[cookbook_name]['exporter']['install_dir'],
  node[cookbook_name]['exporter']['metrics_dir']
].uniq.each do |dir_path|
  directory "cassandra-platform::#{dir_path}" do
    path dir_path
    recursive true
    mode '0755'
  end
end

script = <<-BASH.gsub(/^  /, '')
  #!/bin/bash

  ID=$(#{nodetool} info | grep ID | awk '{print $3}')
  #{nodetool} status > /tmp/nodetool_status
  BASE_CMD=$(cat /tmp/nodetool_status | grep $ID)

  status=$(echo $BASE_CMD | awk '{print $1}')
  owns=$(echo $BASE_CMD | awk '{print $6}' | cut -d. -f1)
  loads_unit=$(echo $BASE_CMD | awk '{print $3 $4}' | sed 's/.$//')
  loads_byte=$(numfmt --from=auto $loads_unit)

  if [ "$status" == "UN" ]; then
    status_num=0
  else
    status_num=1
  fi

  cat <<EOF
  # TYPE node_cassandra__status_num GAUGE
  node_cassandra_cluster_status $(echo $status_num)
  # TYPE node_cassandra_cluster_owns_percent GAUGE
  node_cassandra_cluster_owns_percent $owns
  # TYPE node_cassandra_cluster_loads GAUGE
  node_cassandra_cluster_loads $loads_byte
  EOF
BASH

# Copy cassandra exporter script
exporter_filename =
  "#{node[cookbook_name]['exporter']['install_dir']}/cassandra_exporter.sh"

file exporter_filename do
  content script
  mode '0755'
  action :create
end

# Configure exporter systemd unit
systemd_unit 'cassandra-exporter.service' do
  content node[cookbook_name]['exporter']['unit']
  action %i[create enable]
end

# Configure exporter systemd timer unit
systemd_unit 'cassandra-exporter.timer' do
  content node[cookbook_name]['exporter']['timer_unit']
  action %i[create enable start]
end
