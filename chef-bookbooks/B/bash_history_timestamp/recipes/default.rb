#
# Cookbook Name:: bash_history_timestamp
# Recipe:: default
#
# Copyright (c) 2015 Dan Stark <dstark75@gmail.com>, All Rights Reserved.


node['bash_history_timestamp']['managed_users'].each do |usr,_|
  user usr do
    action :create
    manage_home true
  end

  ## TODO: allow override of user home
  
  # We need to reload ohai after each user is created 
  # We also need lazy attribute evaluation, since the user home dir doesn't exist at compile time.
  # See: https://docs.chef.io/resource_common.html#lazy-attribute-evaluation

  ohai "reload" do
    action :reload
  end

  file "user bashfile" do
    path lazy { "#{node['etc']['passwd'][usr]['dir']}/.bashrc" }
    action :create_if_missing
    mode 0400
    owner usr
    group usr
  end

  replace_or_add 'HISTTIMEFORMAT' do
    path lazy { "#{node['etc']['passwd'][usr]['dir']}/.bashrc" }
    pattern 'export HISTTIMEFORMAT*'
    line "export HISTTIMEFORMAT='#{node['bash_history_timestamp']['flags']}'"
  end

  bash "reload_shell" do
    code lazy { "source #{node['etc']['passwd'][usr]['dir']}/.bashrc" }
    action :nothing
  end
end
