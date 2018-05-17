# rancher-ha
This cookbook installs Rancher Server. You can apply it to multiple nodes for a highly available configuration.

Depending on the version of Rancher you wish to install, you must have a supported version of Docker.

See the [Rancher HA Documentation](http://rancher.com/docs/rancher/v1.6/en/installing-rancher/installing-server/#multi-nodes) for more details.

# REQUIREMENTS
- Supported version of Docker
- Tested with Chef 14.0.202
- Tested on Ubuntu 16.04

# USAGE

### ATTRIBUTES
`attributes/default.rb` - default values.

### RECIPES
`recipes/db.rb` - database setup and configuration  
`recipes/default.rb` - creates data bag 'rancher' if it does not exist  
`recipes/nginx.rb` - generates self-signed certificate, builds configs, sets up Nginx container, and links with 'rancher-server' container  
`recipes/server.rb` - sets up Rancher server and connects to database specified  
