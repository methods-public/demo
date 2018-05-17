[![Build Status](https://secure.travis-ci.org/marthag8/cookbook-thruk.png)](http://travis-ci.org/marthag8/cookbook-thruk)

Description
===========

Thruk is a multibackend monitoring web interface which currently
supports Nagios, Icinga and Shinken as backend using the Livestatus
API. It is designed to be a drop in replacement and covers almost all
of the original features plus adds additional enhancements for large
installations.

See http://www.thruk.org/ for more information.

Requirements
============

#### cookbooks
- `apache2`
- `yum`
- `yum-epel`
- `apt`

Attributes
==========

Usage
=====

The 2.0.0 version of this cookbook moves the configuration attributes
for thruk_local.conf to a hash (node['thruk']['conf']). This allows
you to configure any settings for thruk, but you must change your
current configuration.

#### thruk::default
Use the recipe directly, or include it in a role to customize it:

    % cat roles/thruk.rb
    name 'thruk'
    run_list( 'recipe[thruk]' )
    override_attributes(
      'thruk' => {
        'server_name' => 'monitor.example.com'
        'use_ssl' => true,
        'htpasswd' => '/etc/shinken/htpasswd.users',
        'cert_cookbook' => 'my_cookbook',
        'cert_name' => '_.example.com',
        'cert_ca_name' => 'gd_bundle',
        'icon_cookbook' => 'my_cookbook',
	'conf' => {
          'start_page' => '/thruk/cgi-bin/tac.cgi',
          'first_day_of_week' => 0,
          'csrf_allowed_hosts' => '192.168.0.1',
          'disable_user_password_change' => 1,
          'enable_shinken_features' => 1,
          'logo_path_prefix' => '/thruk/icons/',
          'use_strict_host_authorization' => 1,
	},
        'shinken_priorities' => {
	  '5' => 'Top Production',
          '4' => 'Production',
          '3' => 'Integration',
          '2' => 'Internal',
          '1' => 'Testing',
          '0' => 'Development',
        },
        'backends' => {
          'shinken' => {
            'name' => 'External Shinken',
            'type' => 'livestatus',
            'options' => {
              'peer' => '127.0.0.1:50000',
            },
          },
        },
        'cmd_defaults' => {
          'ahas' => 1,
          'force_check' => 1,
          'persistent_ack' => 1,
          'sticky_ack' => 0,
          'send_notification' => 0,
          'persistent_comments' => 0,
        },
        'cgi' => {
           'admin_group' => 'sysadmin',
           'read_groups' => 'dev,misc',
           'lock_authors_names' => 0,
        },
     },
   )

Contributing
============

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
===================
Authors: Martha Greenberg
