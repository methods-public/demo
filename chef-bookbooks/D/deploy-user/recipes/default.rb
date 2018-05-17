group node['capistrano']['group'] do
  gid if node['capistrano']['gid']
end if node['capistrano']['group']

user_data_bag = node['capistrano']['user_data_bag']
data_bag(user_data_bag).each do |bag_item_id|
  if node['capistrano']['user_data_bag_encrypted']
    u = Chef::EncryptedDataBagItem.load(user_data_bag, bag_item_id)
  else
    u = data_bag_item(user_data_bag, bag_item_id)
  end
  u['username'] ||= u['id']

  next unless u['groups'].include? node['capistrano']['group']

  case node['platform_family']
  when 'mac_os_x'
    home_basedir = '/Users'
  when 'debian', 'rhel', 'fedora', 'arch', 'suse', 'freebsd'
    home_basedir = '/home'
  end

  home_dir = if u['home']
               u['home']
             else
               "#{home_basedir}/#{u['username']}"
             end

  u['groups'].each do |groupname|
    group groupname
  end

  user u['username'] do
    gid u['groups'].first
  end

  directory "#{home_dir}/.ssh" do
    owner u['username']
    group u['gid'] || u['username']
    mode '0700'
  end

  if u['ssh_private_key']
    key_type = u['ssh_private_key'].include?('BEGIN RSA PRIVATE KEY') ? 'rsa' : 'dsa'
    file "#{home_dir}/.ssh/id_#{key_type}" do
      content u['ssh_private_key']
      owner u['id']
      group u['gid'] || u['id']
      mode '0400'
    end
  end

  if u['ssh_public_key']
    key_type = u['ssh_public_key'].include?('ssh-rsa') ? 'rsa' : 'dsa'
    file "#{home_dir}/.ssh/id_#{key_type}.pub" do
      content u['ssh_public_key']
      owner u['id']
      group u['gid'] || u['id']
      mode '0400'
    end
  end
end if node['capistrano']['group'] && node['capistrano']['user_data_bag']

node['capistrano']['known_hosts'].each do |host, host_key|
  ssh_known_hosts_entry host do
    key host_key if host_key
  end
end
