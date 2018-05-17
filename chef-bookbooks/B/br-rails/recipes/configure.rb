#
# Cookbook Name:: br-rails
# Recipe:: configure
#

extend BR::Rails::Recipe

applications.each do |name, application|
  rails_application name do
    root application['root']
    ruby application['ruby']
    config application['config']
    environment application['environment']

    action :configure
  end
end

# application.rb
# database.yml
# other yaml config
# environments file
# ENV settings
# secret file
# initializers
