# This is an example recipe only, not meant to be used for production deployment.
# This should serve as an example of how to use the resource to set up a client.
# See more in the README.md and in test/fixtures/cookbooks for more examples.

pertino_client 'default' do
  auth_mode 'userpass'
  username node['pertino']['example']['username']
  password node['pertino']['example']['password']
end
