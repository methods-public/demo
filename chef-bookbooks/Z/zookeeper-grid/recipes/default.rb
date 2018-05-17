#
# Cookbook Name:: zookeeper-grid
# Recipe:: default
#
# Copyright 2013-2017, whitestar
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

require 'digest/md5'

users = {
  hadoop:    { name: 'hadoop',    uid: 10_001 },
  zookeeper: { name: 'zookeeper', uid: 10_050 },
}

conf_files = [
  'configuration.xsl',
  'jaas.conf',
  'java.env',
  'log4j.properties',
  'zoo.cfg',
  'zoo_sample.cfg',
  'zookeeper-env.sh',
]

def conf_template(conf_dir, conf_files, tpl_vars)
  conf_files.each {|conf_file|
    template "#{conf_dir}/#{conf_file}" do
      source "conf/#{conf_file}"
      #source "conf-#{middle_version}/#{conf_file}"
      owner 'root'
      group 'root'
      mode '0644'
      variables(tpl_vars)
    end
  }
end

version = node['zookeeper']['version']

if /^(\d+)\.(\d+)\.(\d+)$/ =~ version
  major_version = $1
  middle_version = "#{$1}.#{$2}"
  Chef::Application.info("ZooKeeper version: major (#{major_version}), middle (#{middle_version})")
else
  Chef::Application.fatal!("Invalid ZooKeeper version: #{version}")
end

users.each {|key, user|
  next if key == :hadoop

  group user[:name] do
    gid user[:uid]
    members []
    action :create
    not_if "getent group #{user[:name]}"
  end

  user user[:name] do
    uid user[:uid]
    gid user[:uid]
    home "/home/#{user[:name]}"
    shell '/bin/sh'
    password nil
    supports manage_home: false
    not_if "getent passwd #{user[:name]}"
  end
}

if node['zookeeper']['member_of_hadoop']
  g_id = nil
  act = nil
  if shell_out("getent group #{users[:hadoop][:name]}").exitstatus == 0
    g_id = nil
    act = :modify
  else
    g_id = users[:hadoop][:uid]
    act = :create
  end

  group 'add_zookeeper_to_hadoop' do
    group_name users[:hadoop][:name]
    gid g_id
    members ['zookeeper']
    append true
    action act
  end
end

file_cache_path = Chef::Config[:file_cache_path]
install_root = "#{node['grid']['app_root']}/zookeeper-#{version}"
tarball = "zookeeper-#{version}.tar.gz"
tarball_md5 = "#{tarball}.md5"
#tarball_mds = "#{tarball}.mds"
downloaded_tarball = "#{file_cache_path}/#{tarball}"
downloaded_tarball_md5 = "#{file_cache_path}/#{tarball_md5}"
#downloaded_tarball_mds = "#{file_cache_path}/#{tarball_mds}"

archive_url = node['zookeeper']['archive_url']
unless FileTest.directory? install_root
  remote_file downloaded_tarball_md5 do
    source "#{archive_url}/zookeeper-#{version}/#{tarball_md5}"
    action :create_if_missing
  end
=begin
  remote_file downloaded_tarball_mds do
    source "#{archive_url}/zookeeper-#{version}/#{tarball_mds}"
    action :create_if_missing
  end
=end

  remote_file downloaded_tarball do
    source "#{archive_url}/zookeeper-#{version}/#{tarball}"
    action :create_if_missing
  end

  ruby_block "checksum #{downloaded_tarball}" do
    block do
      # e.g. md file format 'f64fef86c0bf2e5e0484d19425b22dcb  zookeeper-3.4.5.tar.gz'
      /^(\w+)\s+.*$/ =~ File.read(downloaded_tarball_md5)
      checksum = $1
      Chef::Log.info "#{tarball}: MD5 = #{checksum}"
      actual_checksum = Digest::MD5.file(downloaded_tarball).to_s
      Chef::Log.info "#{tarball}: actual MD5 = #{actual_checksum}"
      unless checksum.casecmp(actual_checksum)
        Chef::Application.fatal!("Invalid MD5 checksum of #{downloaded_tarball}, expected: #{checksum}")
      end
=begin
      checksum = File.read(downloaded_tarball_mds).
        gsub(/(\s)+/, '').
        scan(/#{tarball}:(.+?)=([0-9A-Z]+)/).
        assoc('SHA256')[1]
      Chef::Log.info "#{tarball}: SHA256 = #{checksum}"
      if ! Digest::SHA256.file(downloaded_tarball).to_s.casecmp(checksum) then
        Chef::Application.fatal!("Invalid SHA256 checksum of #{downloaded_tarball}, expected: #{checksum}")
      end
=end
    end
    action :create
  end

  pkg = 'tar'
  resources(package: pkg) rescue package pkg do
    action :install
  end

  bash 'install_zookeeper' do
    code <<-EOC
      tar xvzf #{downloaded_tarball} -C #{node['grid']['app_root']}
    EOC
    creates install_root
  end
end

zk_prefix = node['zookeeper']['ZOOKEEPER_PREFIX']
link zk_prefix do
  to install_root
  action [:delete, :create]
end

case node['zookeeper']['run_mode']
when 'standalone'
  node_id = 'standalone'
  conf_dir = "#{install_root}/conf.#{node_id}"
  directory conf_dir do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    recursive true
  end

  %w( lib log ).each {|dir|
    directory "#{node['grid']['vol_root']}/0/var/#{dir}/zookeeper/#{node_id}" do
      owner 'zookeeper'
      group 'zookeeper'
      mode '0755'
      action :create
      recursive true
    end
  }

  tpl_vars = {
    node_id: node_id,
    conf_dir: conf_dir,
    clientPort: node['zookeeper']['clientPort'],
  }
  conf_template(conf_dir, conf_files, tpl_vars)

  log <<-EOM
Note:
Start command:
$ cd $ZOOKEEPER_PREFIX
$ sudo -u zookeeper sh -c 'export ZOOCFGDIR=/grid/usr/zookeeper/conf.standalone;./bin/zkServer.sh start'
  EOM
when 'pseudo-replicated'
  client_port = node['zookeeper']['clientPort'].to_i
  3.times {|node_id|
    conf_dir = "#{install_root}/conf.#{node_id}"
    directory conf_dir do
      owner 'root'
      group 'root'
      mode '0755'
      action :create
      recursive true
    end

    %w( lib log ).each {|dir|
      directory "#{node['grid']['vol_root']}/0/var/#{dir}/zookeeper/#{node_id}" do
        owner 'zookeeper'
        group 'zookeeper'
        mode '0755'
        action :create
        recursive true
      end
    }

    myid_file = "#{node['grid']['vol_root']}/0/var/lib/zookeeper/#{node_id}/myid"
    bash "setup_myid_#{node_id}" do
      code <<-EOC
        echo #{node_id} > #{myid_file}
      EOC
      creates myid_file
    end

    tpl_vars = {
      node_id: node_id,
      conf_dir: conf_dir,
      clientPort: client_port,
    }
    conf_template(conf_dir, conf_files, tpl_vars)

    client_port += 1
  }

  log <<-EOM
Note:
Start command:
$ cd $ZOOKEEPER_PREFIX
$ sudo -u zookeeper sh -c 'export ZOOCFGDIR=/grid/usr/zookeeper/conf.0;./bin/zkServer.sh start'
$ sudo -u zookeeper sh -c 'export ZOOCFGDIR=/grid/usr/zookeeper/conf.1;./bin/zkServer.sh start'
$ sudo -u zookeeper sh -c 'export ZOOCFGDIR=/grid/usr/zookeeper/conf.2;./bin/zkServer.sh start'
  EOM
when 'full-replicated'
  conf_dir = "#{install_root}/conf"
  %w( lib log ).each {|dir|
    directory "#{node['grid']['vol_root']}/0/var/#{dir}/zookeeper" do
      owner 'zookeeper'
      group 'zookeeper'
      mode '0755'
      action :create
      recursive true
    end
  }

  data_log_dir = node['zookeeper']['dataLogDir']
  directory data_log_dir do
    owner 'zookeeper'
    group 'zookeeper'
    mode '0755'
    action :create
    recursive true
    only_if { !data_log_dir.nil? && data_log_dir != '' }
  end

  tpl_vars = {
    node_id: '',
    conf_dir: conf_dir,
    clientPort: node['zookeeper']['clientPort'],
  }
  conf_template(conf_dir, conf_files, tpl_vars)

  node_id = ''
  node['zookeeper']['ensemble'].each {|id, server|
    if server['hostname'] == node['fqdn']
      node_id = id
      break
    end
  }
  myid_file = "#{node['grid']['vol_root']}/0/var/lib/zookeeper/myid"
  bash "setup_myid_#{node_id}" do
    code <<-EOC
      echo #{node_id} > #{myid_file}
    EOC
    creates myid_file
  end

  log <<-EOM
Note:
Start command:
$ cd $ZOOKEEPER_PREFIX
$ sudo -u zookeeper ./bin/zkServer.sh start
  EOM
end

# with security
directory "#{node['zookeeper']['keytab_dir']} for zookeeper" do
  path node['zookeeper']['keytab_dir']
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  recursive true
  only_if { node['zookeeper']['with_security'] }
end
