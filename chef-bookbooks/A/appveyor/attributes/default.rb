#
# Cookbook Name:: appveyor
#
# Copyright (C) 2015 Brafton Inc.
#
# All rights reserved - Do Not Redistribute
#

default['appveyor']['agent']['access_key'] = 'CHANGE ME'
default['appveyor']['agent']['location'] = 'C:\\Program Files (x86)\\AppVeyor\\DeploymentAgent\\Appveyor.DeploymentAgent.Service.exe'
default['appveyor']['agent']['source'] = 'http://www.appveyor.com/downloads/AppveyorDeploymentAgent.msi'
default['appveyor']['agent']['deployment_group'] = nil
