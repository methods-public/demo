#
# Cookbook Name:: r1337-certmanage
# Recipe:: certdeploy
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# This recipe deploys the SSL certificates and their corresponding keys from Chef Vault

case node['platform']
  when 'ubuntu', 'centos'

    # Load certs from the specified encrypted data bag ("certificates" by default)
    certs = data_bag(node['r1337-certmanage']['cert_bag']) # Declare our encrypted data bag
    certs.delete_if { |key| key.to_s.match /^.*_keys$/ } # Make sure we don't load vault key lists
    certs.each do |enccert| # For each encrypted data bag item

      # If in Kitchen we will need to use a local data bag instead of a chef server data bag
      if ENV['TEST_KITCHEN'] # Check if running Kitchen
        cert = Chef::EncryptedDataBagItem.load('certificates', enccert)

      else
        # Load certificates from Chef Vault
        cert = ChefVault::Item.load(node['r1337-certmanage']['cert_bag'], enccert)
      end

      # Deploy the Apache-style certificate
      file "/data/ssl/certs/A-#{cert['fqdn']}.crt" do
        path "/data/ssl/certs/A-#{cert['fqdn']}.crt"
        owner 'root'
        group 'root'
        mode '640'
        content "#{cert['cert']}"
      end

      # Deploy the NginX-style certificate
      file "/data/ssl/certs/N-#{cert['fqdn']}.crt" do
        path "/data/ssl/certs/N-#{cert['fqdn']}.crt"
        owner 'root'
        group 'root'
        mode '640'
        content "#{cert['cert']}" + "#{cert['cabundle']}"
      end

      # Deploy the CA-bundle certificate
      file "/data/ssl/certs/A-#{cert['fqdn']}.ca-bundle" do
        path "/data/ssl/certs/A-#{cert['fqdn']}.ca-bundle"
        owner 'root'
        group 'root'
        mode '640'
        content "#{cert['cabundle']}"
      end

      # Deploy the key
      file "/data/ssl/keys/#{cert['fqdn']}.key" do
        path "/data/ssl/keys/#{cert['fqdn']}.key"
        owner 'root'
        group 'root'
        mode '640'
        content "#{cert['key']}"
      end
    end
  else
    # Do nothing
end
