#
# Cookbook Name:: dotnetcore
# Recipe:: _windows
#
# Copyright (C) 2016 Andrew Cornies
#
# All rights reserved - Do Not Redistribute
#

packages = {
  'vcredist2015' => 'https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe',
  'dotnetcore' => node['dotnetcore']['package']['source_url']
}

packages.each do |k,v|
  windows_package k do
    source v
    installer_type :custom
    options '/s /v"/qn"'
    returns [0, 42, 127, 1638]
  end
end
