# -*- mode: ruby; coding: utf-8; -*-

default['git_user']['include_git_recipe'] = true
default['git_user']['data_bag_name'] = 'users'
default['git_user']['gitconfig']['alias'] = {
  'co' => 'checkout',
  'ci' => 'commit',
  'rb' => 'rebase',
  'st' => 'status'
}
default['git_user']['gitconfig']['color'] = {
  'status' => 'auto',
  'branch' => 'auto',
  'ui' => 'auto'
}
