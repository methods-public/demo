# Pattern for datetimeformat.
default['bash_history_timestamp']['flags'] = '%F %T '

# Assume this lives under /root.
default['bash_history_timestamp']['bash_file'] = '.bashrc'

# Array of users. Kitchen test also includes 'testuser' (in .kitchen.yml).
# Users should be managed by Chef to ensure they are added to Ohai. 
default['bash_history_timestamp']['managed_users'] = ['root']
