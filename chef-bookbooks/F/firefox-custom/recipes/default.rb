#
# Cookbook Name:: firefox-custom
# Recipe:: default
#
# Copyright (C) 2015 digitalr00ts
# http://digitalr00ts.com
#

include_recipe 'firefox'

# mozilla.cfg - Set global preferences
if node['firefox-custom']['local-settings'].nil? || node['firefox-custom']['local-settings'].strip.empty? || !defined?(node['firefox-custom']['local-settings'])

  # 32-bit OS #
  cookbook_file 'local-settings.js' do
    action :create
    if node['platform'] == 'windows'
      path "#{ENV['ProgramFiles(x86)']}\\Mozilla Firefox\\defaults\\pref\\local-settings.js"
      only_if { ::File.directory?("#{ENV['ProgramFiles(x86)']}\\Mozilla Firefox") }
    elsif node['platform'] == 'mac_os_x'
      if node['firefox']['version'] == 'latest' || node['firefox']['version'] >= 34
        path '/Applications/Firefox.app/Contents/MacOS/defaults/local-settings.js'
      else
        path '/Applications/Firefox.app/Contents/MacOS/defaults/pref/local-settings.js'
      end
    else # assume Linux or Unix
      path '/usr/lib/firefox/browser/defaults/preferences/local-settings.js'
      only_if { ::File.directory?('/usr/lib/firefox/') }
    end
    source 'local-settings.js'
  end

  cookbook_file 'mozilla.cfg' do
    action :create
    if node['platform'] == 'windows'
      path "#{ENV['ProgramFiles(x86)']}\\Mozilla Firefox\\mozilla.cfg"
      only_if { ::File.directory?("#{ENV['ProgramFiles(x86)']}\\Mozilla Firefox") }
    elsif node['platform'] == 'mac_os_x'
      path '/Applications/Firefox.app/Contents/MacOS/mozilla.cfg'
    else # assume Linux or Unix
      path '/usr/lib/firefox/mozilla.cfg'
      only_if { ::File.directory?('/usr/lib/firefox/') }
    end
    source 'mozilla.cfg'
  end

  # 64-bit OS #
  cookbook_file 'local-settings.js-64' do
    action :create
    if node['platform'] == 'windows'
      path "#{ENV['ProgramFiles']}\\Mozilla Firefox\\defaults\\pref\\local-settings.js"
      only_if { ::File.directory?("#{ENV['ProgramFiles']}\\Mozilla Firefox") }
    else # assume Linux or Unix
      path '/usr/lib64/firefox/browser/defaults/preferences/local-settings.js'
      only_if { ::File.directory?('/usr/lib64/firefox/') }
    end
    source 'local-settings.js'
    not_if { node['platform'] == 'mac_os_x' }
  end

  cookbook_file 'mozilla.cfg-64' do
    action :create
    if node['platform'] == 'windows'
      path "#{ENV['ProgramFiles']}\\Mozilla Firefox\\mozilla.cfg"
      only_if { ::File.directory?("#{ENV['ProgramFiles']}\\Mozilla Firefox") }
    else # assume Linux or Unix
      path '/usr/lib64/firefox/mozilla.cfg'
      only_if { ::File.directory?('/usr/lib64/firefox/') }
    end
    source 'mozilla.cfg'
  end

end
