#
# Cookbook Name:: backupdir
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

# https://github.com/DennyZhang/backup_dir
remote_file '/opt/mdm/bin/backup_dir.sh' do
  source 'https://raw.githubusercontent.com/DennyZhang/backup_dir/master/backup_dir.sh'
  mode '0755'
  retries 3
end

