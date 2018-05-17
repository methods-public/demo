#
# Cookbook Name:: br-rails
# Recipe:: install
#

extend BR::Rails::Recipe

applications.each do |name, application|
  rails_application name do
    root application['root']
    ruby application['ruby']
    commands application['install']

    not_if { Hash(application['install']).empty? }

    action :install
  end
end
