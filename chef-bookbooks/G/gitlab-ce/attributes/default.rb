default['gitlab-ce']['dependencies'] = %w(curl policycoreutils openssh-server
                                          openssh-clients)
default['gitlab-ce']['manage_postfix'] = true
default['gitlab-ce']['manage_repo'] = true

default['gitlab-ce']['config']['enable_https'] = false
default['gitlab-ce']['config']['external_url'] = node['fqdn']
default['gitlab-ce']['config']['git_data_dir'] = '/var/opt/gitlab/git-data'
default['gitlab-ce']['config']['manage_accounts'] = true
