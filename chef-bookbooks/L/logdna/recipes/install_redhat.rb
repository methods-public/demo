# Recipe for installing LogDNA Agent via Yellowdog Updater, Modified (YUM)

## Adding LogDNA Agent Repo to /etc/yum.repos.d/:
yum_repository 'logdna-agent' do
  description	'LogDNA Agent\'s Stable Repo'
  baseurl 'http://repo.logdna.com/el6/'
  enabled true
  gpgcheck false
end

## Updating the sources; so, LogDNA Agent Repo will be in effect:
execute 'yum_update' do
  command 'yum update -y'
  action :run
end

## Installing LogDNA Agent:
yum_package 'logdna-agent' do
  action :install
end
