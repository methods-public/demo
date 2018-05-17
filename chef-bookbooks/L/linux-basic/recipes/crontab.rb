#
# Cookbook Name:: linux-basic
# Recipe:: crontab
#
# Copyright 2015, http://DennyZhang.com
#
# All rights reserved - Do Not Redistribute
#

#################### daily rotate ###################
cron 'chef_daily_clean' do
  user 'root'
  hour '4'
  minute '0'
  command 'bash -e /usr/local/bin/chef_daily_clean.sh'
end

cron 'cron_clean_memory' do
  user 'root'
  hour '4'
  minute '0'
  command '/usr/local/bin/chef_daily_clean_memory.sh'
end

#####################################################

#################### backup cron ####################
cron 'chef_backup' do
  user 'root'
  hour '2'
  minute '0'
  command '/usr/local/bin/chef_daily_backup.sh'
end

# if node[:global][:enable_remote_backup] == 'true'
#   cron 'remote_copy_backupset' do
#     user 'root'
#     hour '3'
#     # TODO: use a random time
#     minute '20'
#     command 'bash -e /usr/local/bin/remote_copy_backupset.sh >> /var/log/remote_copy_backupset.log 2>&1'
#   end
# end
#####################################################

# cron 'cron_backup_cloudpasskeystore' do
#   user 'root'
#   minute '*/5'
#   command 'bash -e /usr/local/bin/fluig_backup_file.sh /cloudpass/backend/build/bin/CloudpassKeystore >> /var/log/backup_cloudpasskeystore.log 2>&1'
# end
