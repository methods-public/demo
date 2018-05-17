#
# Cookbook Name:: br-rails
# Recipe:: migrate
#

extend BR::Rails::Recipe

applications.each do |name, application|
  rails_application name do
    root application['root']
    ruby application['ruby']
    commands application['migrate']

    not_if { Hash(application['migrate']).empty? }

    action :migrate
  end
end
