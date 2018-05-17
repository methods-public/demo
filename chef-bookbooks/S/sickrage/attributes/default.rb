#
# Cookbook Name:: sickrage
#
# Copyright 2015, Jeremy Miller
#
# All rights reserved - Do Not Redistribute
#
default['sickrage']['user'] = 'sickbeard'
default['sickrage']['group'] = 'sickbeard'
default['sickrage']['listen_port'] = '8081'
default['sickrage']['directory']['install_dir'] = '/opt/sickbeard'
default['sickrage']['directory']['data_dir'] = '/var/sickrage'
default['sickrage']['directory']['config_dir'] = '/etc/sickrage'
default['sickrage']['directory']['pid_dir'] = '/var/run/sickbeard'
default['sickrage']['directory']['lockfile_dir'] = '/var/run/sickbeard/subsys'
default['sickrage']['binary'] = '/opt/sickbeard/SickBeard.py'

# Only a fresh install will take place if this is false
default['sickrage']['config_enabled'] = 'true'
default['sickrage']['log_dir'] = '/var/log/sickbeard'

# Python
default['sickrage']['python']['binary'] = '/usr/local/bin/python2.7'
#  git
default['sickrage']['install_style'] = 'git'

# Git Options
default['sickrage']['git_url'] = 'https://github.com/SickRage/SickRage.git'
default['sickrage']['git_revision'] = 'master'

# Get from running this command: git ls-remote https://github.com/SickRage/SickRage.git master
default['sickrage']['git_ref'] = '8564c29aa3b2d95bf41e03eed7e5a6938f1a6b3a'
