#
# Cookbook:: delphix
# Recipe:: debian
#
# Copyright:: 2018, The Authors, All Rights Reserved.

case node['kernel']['machine']
when 'x86_64'
  execute 'enable_32bit' do
    command 'dpkg --add-architecture i386'
  end
end

%w{libc6:i386 libstdc++6:i386 nfs-common sudo}.each do |pkg|
  package pkg
end
