#
# Cookbook Name:: r1337-sshconfig
# Spec:: hardenedssh
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# # encoding: utf-8

# Inspec test for recipe r1337-sshconfig::hardenedssh

if ['ubuntu', 'centos'].include?(os[:name])
  # Test if using the correct protocol
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /Protocol 2/ }
  end

  # Test if User Privilege Separation is on
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /UsePrivilegeSeparation yes/ }
  end

  # Test if the Key Regeneration Interval is correct
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /KeyRegenerationInterval 3600/ }
  end

  # Test if the Server Key is the correct size
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /ServerKeyBits 2048/ }
  end

  # Test if logs are going to the correct location
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /SyslogFacility AUTH/ }
  end

  # Make sure the logs are verbose so SSH key fingerprints are included
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /LogLevel VERBOSE/ }
  end

  # Make sure the Login grace time is proper
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /LoginGraceTime 60/ }
  end

  # Make sure we only allow root logins with SSH keys only
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /PermitRootLogin without-password/ }
  end

  # Make sure Strict Mode is on
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /StrictModes yes/ }
  end

  # Make sure we are using RSA authentication
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /RsaAuthentication yes/ }
  end

  # Make sure we have public key authentication enabled
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /PubkeyAuthentication yes/ }
  end

  # Make sure password authentication is off for all SSH users
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /PasswordAuthentication no/ }
  end

  # Make sure we ignore Rhosts
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /IgnoreRhosts yes/ }
  end

  # Make sure we don't allow Rhosts authentication
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /RhostsRsaAuthentication no/ }
  end

  # Make sure host based authentication is off
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /HostBasedAuthentication no/ }
  end

  # Do not permit empty passwords
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /PermitEmptyPasswords no/ }
  end

  # Turn off challenge response authentication
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /ChallengeResponseAuthentication no/ }
  end

  # Don't allow X11 forwarding
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /X11Forwarding no/ }
  end

  # Make sure motd isn't printed on login
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /PrintMotd no/ }
  end

  # Print the last login time message
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /PrintLastLog yes/ }
  end

  # Enable TCP keep alive
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /TCPKeepAlive yes/ }
  end

  # Use PAM as a user source
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /UsePAM yes/ }
  end

  # Disable TCPForwarding
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /AllowTcpForwarding no/ }
  end

  # Make sure the login banner is present
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /Banner \/etc\/issue.net/ }
  end
else
  # Do nothing
end

if os[:name] == 'ubuntu'

  # Verify SSH daemon is enabled and running
  describe service('ssh') do
    it { should be_enabled }
    it { should be_running }
  end

  # Check to see if SFTP is configured
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /\/usr\/lib\/openssh\/sftp-server/ }
  end
elsif os[:name] == 'centos'

  # Verify SSH daemon is enabled and running
  describe service('sshd') do
    it { should be_enabled }
    it { should be_running }
  end

  # Check to see if SFTP is configured
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /\/usr\/libexec\/openssh\/sftp-server/ }
  end
else
  # Do nothing
end