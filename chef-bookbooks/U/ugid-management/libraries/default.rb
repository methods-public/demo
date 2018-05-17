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

# Main code of UGId Management
module UGIdManagement
  def manage_ugid_users(whitelist = [])
    %w[group user].each do |type|
      resource_names(type).each do |r_name|
        manage_ugid_user(r_name, whitelist)
      end
    end
  end

  def manage_ugid_user(resource_name, whitelist = [])
    resource = resources(resource_name)
    username = user_or_group(resource)
    return if whitelist.include?(username)
    uid, gid = ugid_of(username)
    resource.gid(gid)
    return unless resource_name.start_with?('user[')
    manage_user(resource, username, uid)
  end

  def manage_ugid_packages
    resource_names('package').each { |r_name| manage_ugid_package(r_name) }
  end

  def manage_ugid_package(resource_name)
    username, user_info = package_user_info(resources(resource_name))
    return if username.nil? || resource_names('user').include?(username)
    uid, gid = ugid_of(username)
    if uid.zero? && gid.zero?
      raise "#{resource} creates user or group #{username} "\
        'but no ugid is defined for this user!'
    end
    create_package_group(username, gid, user_info)
    create_package_user(username, uid, gid, user_info)
  end

  def resource_names(type)
    keys = run_context.resource_collection.send(:resource_set).keys
    all = keys.select { |r| r.start_with?("#{type}[") }
    init_run_state(type)
    all - node.run_state[cookbook_name][type]
  end

  def ugid_of(username)
    ugid_map = data_bag_item('ugids', 'ugids')['ugids']
    ugid = ugid_map[username].to_s.split(':')
    check_ugid(ugid, username)
    [ugid.first.to_i, ugid.last.to_i]
  end

  private

  def init_run_state(type)
    node.run_state[cookbook_name] ||= {}
    node.run_state[cookbook_name][type] ||= []
  end

  def user_or_group(resource)
    return resource.username if resource.respond_to?(:username)
    return resource.group_name if resource.respond_to?(:group_name)
    raise 'Unknown resource type, no username nor group_name'
  end

  def check_ugid(ugid, username)
    return unless node[cookbook_name]['enforce'] && ugid.empty?
    raise "UGId management is enforced but #{username} "\
      'does not have an ugid defined!'
  end

  def manage_user(resource, username, uid)
    if uid.zero?
      raise "Trying to create user #{username}, but its uid is undefined"
    end
    resource.uid(uid)
    default_shell = node[cookbook_name]['default_shell']
    resource.shell || resource.shell(default_shell) unless default_shell.nil?
  end

  def package_user_info(resource)
    user_per_package = data_bag_item('ugids', 'packages')['packages']
    package = resource.package_name
    user_info = user_per_package[package]
    return nil if user_info.nil?
    username = user_info['username']
    if username.nil?
      raise "Empty username for package #{package}, check your data bag"
    end
    [username, user_info]
  end

  def create_package_group(groupname, v_gid, user_info)
    return if v_gid.zero?
    resource = group(groupname) { gid v_gid }
    (user_info['group_opts'] || []).each { |k, v| resource.send(k.to_sym, v) }
    resource.run_action(:create)
  end

  def create_package_user(username, v_uid, v_gid, user_info)
    return if v_uid.zero?
    resource = user username do
      uid v_uid
      gid v_gid unless v_gid.zero?
      home "/var/lib/#{username}"
      shell '/sbin/nologin'
    end
    (user_info['user_opts'] || []).each { |k, v| resource.send(k.to_sym, v) }
    resource.run_action(:create)
  end
end
