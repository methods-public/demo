# rancher\-ng cookbook

Cookbook for installing [Rancher](https://rancher.com/) server & agent

## Supported Platforms

It should work on most Linux distributions.

Tested on Ubuntu and CentOS 7.x.

## Usage

### Attributes

See the `attributes/default.rb` file for default values.

### Recipes

#### server

Setup default Rancher Server container, based on `node['rancher_ng']['server']` attributes.

#### agent

Setup default Rancher Agent container, based on `node['rancher_ng']['agent']` attributes.

### Providers

To use the providers, append the following to your metadata.rb

```ruby
depends 'rancher-ng'
```

#### rancher\_ng\_server

Deploys server container. With this you can skip keys in `server` provider.

```ruby
rancher_ng_server 'name' do
  name 'mycontainer' # Container/Job name
  
  image 'rancher/server' # Server image
  version 'v1.6.0' # Server image version
  
  db_dir '/var/opt/rancher_db' # Rancher's db directory
  port '8080' # Rancher's server port
  
  detach true # Docker's `detach` mode
  restart_policy 'unless-stopped' # Docker's `restart` mode
  
  external_db false # Use external MySQL DB?

  db_container 'mysql' # Use DB in container?
  db_container_version '5.7'
  db_container_command '--max_allowed_packet=32M --innodb_log_file_size=256M --innodb_large_prefix=on --innodb_file_format=Barracuda --innodb_file_per_table=1 --innodb_buffer_pool_size=1GB'
  
  db_host 'localhost' # Database host
  db_port '3306' # Database port
  db_user 'cattle' # Database user
  db_pass 'password' # Database password
  db_name 'cattle' # Database name

  cookbook  'rancher-ng' # Cookbook to take erb template from
  
  action :create # :create, :delete
end
```

#### rancher\_ng\_agent

Deploys agent container. With this you can skip keys in `agent` provider.

```ruby
rancher_ng_agent 'name' do
  name 'mycontainer' # Job name
  
  image 'rancher/agent' # Agent image
  version 'v1.2.2' # Agent image version
  
  labels {
    a: 'some',
    b: 8
  }
  auth_url 'http://yourserver:8080/SOMETOKEN' # Agent's server authentication url
  mount_point '/var/lib/rancher:/var/lib/rancher' # Rancher's volume
  autoremove false # Docker's `autoremove` mode
  privileged true # Docker's `privileged` mode

  cookbook  'rancher-ng' # Cookbook to take erb template from
  
  action :create # :create, :delete
end
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request


## License and Authors

Author: Alexander Merkulov <sasha@merqlove.ru>

Contributors: write me, to be here
