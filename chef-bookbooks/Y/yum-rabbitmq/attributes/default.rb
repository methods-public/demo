default['yum']['rabbitmq']['description'] = 'RabbitMQ Repository'
default['yum']['rabbitmq']['baseurl'] = 'https://dl.bintray.com/rabbitmq/rabbitmq-server-rpm'
default['yum']['rabbitmq']['gpgcheck'] = false
default['yum']['rabbitmq']['enabled'] = true
default['yum']['rabbitmq']['managed'] = true

default['yum']['rabbitmq-erlang']['description'] = 'RabbitMQ Erlang Repository'
default['yum']['rabbitmq-erlang']['baseurl'] = 'https://dl.bintray.com/rabbitmq/erlang'
default['yum']['rabbitmq-erlang']['gpgcheck'] = false
default['yum']['rabbitmq-erlang']['enabled'] = true
default['yum']['rabbitmq-erlang']['managed'] = true
default['yum']['rabbitmq-erlang']['includepkgs'] = "*.el#{platform_version.to_i}.*"
