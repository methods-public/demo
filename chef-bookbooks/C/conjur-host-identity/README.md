# Description

Creates and installs Conjur host identity using Chef attributes and the Conjur 
[host factory](http://developer.conjur.net/reference/services/host_factory).

## Attributes

See the Chef metadata.rb for detailed information about the attributes used by this recipe.

Basically, you should populate Chef attributes which configure the connection to Conjur:

* Appliance URL
* Organization account name
* SSL certificate

The cookbook will auto-detect a SSL certificate at `/etc/conjur-#{account}.pem`.

You also need to provide two other pieces of information:

* Host factory token.
* Id for the host. You can use some data from OHAI (such as the AWS instance id), or the Chef node name,
or whatever you like. It needs to be unique across your Conjur system.

## Conjur gem installation

The Conjur API and Conjur CLI gems are installed by [chef_gem](https://docs.getchef.com/resource_chef_gem.html). 
Therefore they can be used in any other subsequent cookbook as well.

This is very handy for fetching secrets from Conjur. You can find an example in our
[asgard config](https://github.com/conjurdemos/chef-asgard-config/blob/master/recipes/default.rb) demo cookbook.

## Conjur configuration

This cookbook builds `/etc/conjur.conf` from the Conjur connection information. This configuration will be used
by all the downstream Conjur functionality.

File permissions are `0644`.

## Conjur host identity

This cookbook looks for a host identity in `/etc/conjur.identity`. If that file exists, it's left intact.

If it doesn't exist, the host factory token is used to provision a new host identity, which is then saved to the file.
File permissions are `0600`.

The `netrc_path` entry in `conjur.conf` points to `/etc/conjur.identity`. Therefore, downstream Conjur tools such as the
Conjur CLI will automatically pick up the host identity from this file and use it.

# Testing

Once the cookbook has run, you can verify the host identity by running `conjur authn whoami`. For example:

    # /opt/chef/embedded/bin/conjur authn whoami
    {"account":"demo","username":"host/kgilpin@spudling.local/chef-tutorial-1-0/vagrant/ff849c12-95d7-4720-9fb7-2c2be88582f7"}
