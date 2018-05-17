#
# Cookbook Name:: backupdir
# Recipe:: s3_copy
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

unless node['backupdir'].attribute?('backup_dir')
  Chef::Application.fatal!('Required parameter of ' \
                           "['backupdir']['backup_dir'] must be set")
end

unless node['backupdir'].attribute?('aws_access_key_id')
  Chef::Application.fatal!('Required parameter of ' \
                           "['backupdir']['aws_access_key_id'] must be set")
end

unless node['backupdir'].attribute?('aws_secret_access_key')
  Chef::Application.fatal!('Required parameter of '\
                           "['backupdir']['aws_secret_access_key']" \
                           ' must be set')
end

# #####################################################
%w(python-pip).each do |x|
  package x do
    action :install
  end
end

python_pip 'awscli'

directory '/root/.aws' do
  owner 'root'
  group 'root'
  mode 00700
  action :create
end

%w(config credentials).each do |x|
  template "/root/.aws/#{x}" do
    source "aws_#{x}.erb"
    mode '0600'
  end
end

# https://github.com/DennyZhang/S3Sync
remote_file '/opt/mdm/bin/s3sync.sh' do
  source 'https://raw.githubusercontent.com/DennyZhang/S3Sync/master/s3sync.sh'
  mode '0755'
  retries 3
end

# TODO: s3sync.sh backup /data/backup/archive denny-bucket2
#        s3backup/dir1 /opt/dir1/config/s3.metadata
# # #####################################################
