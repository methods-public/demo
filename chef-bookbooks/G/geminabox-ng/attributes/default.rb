# frozen_string_literal: true
default['geminabox-ng'] = {
  'user' => {
    # set a default user for geminabox service,
    # this should be different than nginx server
    'name'        => 'geminabox',
    # Set geminabox home dir
    'home_dir'    => '/opt/geminabox',
    # optionally configurable datadir, defaults to "#{home_dir}/data"
    # 'data_dir'    => nil,
  },

  # Set config options for geminabox server,
  # see https://github.com/geminabox/geminabox
  'config' => {
    'build_legacy'    => false,
    'rubygems_proxy'  => true,
    'allow_remote_failure' => true,
  },

  # default to the latest stable ruby as of the writing of this cookbook
  'ruby_version'  => '2.4.2',

  # list of gems to install,
  # additional gems can be added as environment/node attributes.
  'gems' => {
    'geminabox'   => true,
    'unicorn'     => true,
  },

  # Unicorn cofiguration.
  # For config options see: https://bogomips.org/unicorn/Unicorn/Configurator.html
  'unicorn' => {
    'worker_processes' => 4,
    'port' => '8080',
    # This can be used for debugging purposes.  defaults to 127.0.0.1
    # 'host' => '0.0.0.0',
    'timeout' => 30,
    'preload_app' => true,
    'cow_friendly' => true,
    # Optionally, set a socket listener
    # Setting this will override the http listener,
    # you'll need to generate a different nginx config
    #
    # to create socket in homedir
    # 'socket' => 'unicorn.socket'
    # to create a socket in an alternate directory
    # 'socket' => {
    #   'dir' => '/var/run',
    #   'file_name' => 'unicorn.socket',
    # }
  },

  # By default, we'll run all recipes in the cookbook,
  # set to false to disable a recipe
  # default['geminabox-ng']['run_list']['user'] = false
  'run_list' => {
    # creates the geminabox user, disable if you create users via other processes
    'user'        => true,
    # Installs ruby using rbenv, disable to use another ruby install method
    'ruby'        => true,
    # Installs and configures geminabox,
    # no sense disabling since this is the heart of the cookbook.
    'server'      => true,
    # Sets up a reverse proxy to webrick service.  Currently only supports Nginx
    'proxy'       => true,
  },
}
