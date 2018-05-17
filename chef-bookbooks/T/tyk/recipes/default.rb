# This recipe can be used to install an all-in-one server
# for testing purposes. For production you probably want to
# install Mongo and redis on separate machines. Also you
# will probably want to have more gateways and put the
# dashboard on separate server too.

include_recipe 'redisio'
include_recipe 'redisio::enable'
include_recipe 'mongodb'
include_recipe 'tyk::install_gateway'
include_recipe 'tyk::install_dashboard'
include_recipe 'tyk::install_pump'
