#
# Cookbook Name:: r1337-sshconfig
# Recipe:: hardenedssh
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# This recipe should be used in untrusted environments (DMZs) or in environments with tight security regulations

case node['platform']
  when 'ubuntu', 'centos'

    ### Set all the SSH variables for a secured system

    # Use Protocol 2 as Protocol 1 has been broken
    node.default['openssh']['server']['protocol'] = '2'

    # Separate user privileges
    node.default['openssh']['server']['use_privilege_separation'] = 'yes'

    # Set the key regeneration to hourly
    node.default['openssh']['server']['key_regeneration_interval'] = '3600'

    # Set the server bits to 2048
    node.default['openssh']['server']['server_key_bits'] = '2048'

    # Log to auth.log
    node.default['openssh']['server']['syslog_facility'] = 'AUTH'

    # Set VERBOSE logging so the log contains SSH key fingerprints
    node.default['openssh']['server']['log_level'] = 'VERBOSE'

    # Set a 2 minute grace time for login
    node.default['openssh']['server']['login_grace_time'] = '60'

    # Permit root login with SSH keys only
    node.default['openssh']['server']['permit_root_login'] = 'without-password'

    # Enforce a strict mode
    node.default['openssh']['server']['strict_modes'] = 'yes'

    # Use RSA authentication
    node.default['openssh']['server']['rsa_authentication'] = 'yes'

    # Allow public key authentication
    node.default['openssh']['server']['pubkey_authentication'] = 'yes'

    # Don't allow password authentication
    node.default['openssh']['server']['password_authentication'] = 'no'

    # Ignore RHosts
    node.default['openssh']['server']['ignore_rhosts'] = 'yes'

    # Don't allow RHosts RSA authentication
    node.default['openssh']['server']['rhosts_rsa_authentication'] = 'no'

    # Don't allow host based authentication
    node.default['openssh']['server']['host_based_authentication'] = 'no'

    # Don't permit empty passwords
    node.default['openssh']['server']['permit_empty_passwords'] = 'no'

    # Disable challenge response authentication
    node.default['openssh']['server']['challenge_response_authentication'] = 'no'

    # Allow X11 forwarding
    node.default['openssh']['server']['x11_forwarding'] = 'no'

    # Disable printing MOTD on login. (Otherwise we'd see the login banner twice)
    node.default['openssh']['server']['print_motd'] = 'no'

    # Show the last login for the user
    node.default['openssh']['server']['print_last_log'] = 'yes'

    # Enable TCP keep alive
    node.default['openssh']['server']['t_c_p_keep_alive'] = 'yes'

    # Use PAM as a source of user accounts
    node.default['openssh']['server']['use_p_a_m'] = 'yes'

    # Disable TCPForwarding
    node.default['openssh']['server']['allow_tcp_forwarding'] = 'no'

    # Set the banner to /etc/issue.net (used in conjunction with anet-loginbanner)
    node.default['openssh']['server']['banner'] = '/etc/issue.net'
  else
    # Do nothing
end

# The case block below will set the ssh service to be enabled and running with the correct name depending on platform
case node['platform']
  when 'ubuntu'

    # Make sure the SSH config is enabled and running
    service 'ssh' do
      action [:enable, :start]
    end

    # Configure SFTP
    node.default['openssh']['server']['subsystem'] = 'sftp /usr/lib/openssh/sftp-server'

    # Include the openssh cookbook to perform the configuration based on the node.default options set above
    include_recipe 'openssh::default'

  when 'centos'

    # Make sure the SSH config is enabled and running
    service 'sshd' do
      action [:enable, :start]
    end

    # Configure SFTP
    node.default['openssh']['server']['subsystem'] = 'sftp /usr/libexec/openssh/sftp-server'

    # Include the openssh cookbook to perform the configuration based on the node.default options set above
    include_recipe 'openssh::default'
  else
    # Do nothing
end
