conjur-host-identity-library
====================
conjur-host-identity-library is a library cookbook that provides a conjurize resource for use in recipes.

Usage
-----
```ruby
conjurize 'host-identity' do
  account            node['conjur']['account']
  appliance_url      node['conjur']['appliance_url']
  host_identity      node['fqdn']
  host_factory_token node['service-host']['host_factory_token']
  ssl_certificate    node['conjur']['certificate']
  ssh                true
end
```

Attributes
----------

### conjurize
| Attribute name  | Description                 | Required | Default |
|-----------------|-----------------------------|----------|---------|
| `account` | Name of the account that Conjur was configured with | Yes | |
| `appliance_url` | URL to the Conjur appliance | Yes | |
| `host_identity` | Name of the host to be created. If left blank, the host will be assigned a UUID. | No | Random UUID |
| `host_factory_token` | The host factory token to be used in exchange for a Conjur identity | Yes | |
| `appliance_url` | The contents of the SSL certificate to verify the Conjur server  __or__ the path to an existing certificate on disk | Yes | |
| `ssh` | If true, the machine will run the [Conjur cookbook](https://github.com/conjur-cookbooks/conjur), configuring the machine for SSH and audit logging. | No | false |
| `overwrite` | If true, any existing identity on the machine will be overwritten. | No | false |
