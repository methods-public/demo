#
# Copyright (c) 2016 Sam4Mobile, 2017-2018 Make.org
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

read_users_groups = lambda do
  users_groups = {}
  File.foreach('/etc/group') do |group|
    groupname, _x, gid, _members = group.chomp.split(':')
    users_groups[groupname] = { 'uid' => 0, 'gid' => gid.to_i }
  end
  File.foreach('/etc/passwd') do |user|
    username, _x, uid, gid, _, home, shell = user.chomp.split(':')
    users_groups[username] = {
      'uid' => uid.to_i, 'gid' => gid.to_i, 'home' => home, 'shell' => shell
    }
  end
  users_groups
end

check_and_raise_error = lambda do |invalids|
  unless invalids.empty?
    invalids_str = invalids.join(', ')
    msg = "[UGId control] These users/groups are invalid: #{invalids_str}"
    raise msg if node[cookbook_name]['output_file'].nil?
    Mixlib::ShellOut.new(
      "echo #{msg} >> #{node[cookbook_name]['output_file']}"
    ).run_command
  end
end

is_valid = lambda do |name, value, ugid_map|
  ugid = ugid_map[name].to_s.split(':')
  uid = ugid.first.to_i
  gid = ugid.last.to_i
  uid != value['uid'].to_i || gid != value['gid'].to_i
end

check_ugid = proc do
  users_groups = read_users_groups.call.select do |_name, value|
    value['uid'] > 200 || (value['uid'].zero? && value['gid'] > 200)
  end

  ugid_map = data_bag_item('ugids', 'ugids')['ugids']

  invalids = users_groups.select do |name, value|
    is_valid.call(name, value, ugid_map)
  end

  whitelist = node[cookbook_name]['whitelist']
  invalids = invalids.keys - whitelist

  check_and_raise_error.call(invalids)
end

# Use delayed_action to check at the very end of the run
ugid_management_proc 'check ugid on users/groups' do
  proc check_ugid
  action :nothing
  delayed_action :run
end
