#
# Cookbook Name:: google-cloud-logging
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "/tmp/install_logging.sh" do
  source "install_logging.sh"
  mode "0744"
end
execute 'install google-cloud-logging agent' do
  command 'sh /tmp/install_logging.sh'
end
