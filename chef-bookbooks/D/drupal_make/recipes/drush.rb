#
# Cookbook Name:: drupal_make
# Recipe:: drush
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

composer_home = ::File.expand_path("~#{ node[:drupal_make][:drush][:user] }/.composer")
composer_drush_path = "#{ composer_home }/vendor/bin/drush"

drush_version = node[:drupal_make][:drush][:version] == '7.x' ? 'dev-master' : node[:drush_make][:drush][:version]

execute 'drupal-make-drush-install' do
  creates composer_drush_path
  command  "#{ node[:drupal_make][:drush][:composer_command] } global require drush/drush:#{ drush_version }"
  user node[:drupal_make][:drush][:user]
  group node[:drupal_make][:drush][:group]
  environment({
    'COMPOSER_HOME' => composer_home
  })
end

link node[:drupal_make][:drush][:install_path] do
  to composer_drush_path
  owner node[:drupal_make][:drush][:user]
  mode '0777'
end