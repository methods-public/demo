#
# Cookbook Name:: dotnetcore
# Attribute:: default
#
# Copyright (C) 2016 Andrew Cornies
#
# All rights reserved - Do Not Redistribute
#

default['dotnetcore']['package']['name'] = 'dotnet-dev-1.0.0-preview2-003131'
default['dotnetcore']['package']['source_url'] = 'https://download.microsoft.com/download/5/5/7/557D02A5-C3D0-4EF6-A570-4F75CD0DA5BF/DotNetCore.1.0.1-WindowsHosting.exe'
default['dotnetcore']['package']['tar'] = 'https://go.microsoft.com/fwlink/?LinkID=827529'
default['dotnetcore']['apt_package_source'] = 'http://apt-mo.trafficmanager.net/repos/dotnet-release'
