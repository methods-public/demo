# -*- mode: ruby; coding: utf-8; -*-

include_recipe 'git' if node['git_user']['include_git_recipe']
