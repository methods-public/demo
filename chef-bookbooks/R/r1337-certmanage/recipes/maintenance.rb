#
# Cookbook Name:: r1337-certmanage
# Recipe:: maintenance
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# This recipe performs cleanup of removed certs and keys as well as unmanaged files in the /data/ssl directory

# The below case block contains functions that will only run in Test Kitchen
# The purpose is to create files that are not tracked as Chef resources so we can test the clean up function of the maintenance recipe
case node['platform']
  when 'ubuntu', 'centos'

# If in Kitchen we will create some sample data for the maintenance recipe to clean up
if ENV['TEST_KITCHEN'] # Check if running Kitchen

  execute 'creating test dir' do
    command 'mkdir /data/ssl/baddir'
  end

  execute 'creating fake file #1' do
    command 'echo "This is not approved" > /data/ssl/unapprovedfile.txt'
  end

  execute 'creating fake file #2' do
    command 'echo "This is a fake key" > /data/ssl/baddir/fakekey.txt'
  end

else
  # Do nothing
end

  else
    # Do nothing
end

# This case block contains the code that will run in production
case node['platform']
  when 'ubuntu', 'centos'

    # Check for unmanaged files and directories in the /data/ssl directory and remove them
    managed_directory '/data/ssl' do
      path '/data/ssl'
      action :clean
      clean_directories true
    end
  # Check for unmanaged files and directories in the /data/ssl/certs directory and remove them
    managed_directory '/data/ssl/certs' do
      path '/data/ssl/certs'
      action :clean
      clean_directories true
    end
  # Check for unmanaged files and directories in the /data/ssl/keys directory and remove them
    managed_directory '/data/ssl/keys' do
      path '/data/ssl/keys'
      action :clean
      clean_directories true
    end

  else
    # Do nothing
end