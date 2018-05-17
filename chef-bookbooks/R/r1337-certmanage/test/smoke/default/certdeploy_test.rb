#
# Cookbook Name:: r1337-certmanage
# Spec:: certdeploy
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# # encoding: utf-8

# Inspec test for recipe r1337-certmanage::certdeploy

if ['ubuntu', 'centos'].include?(os[:name])

  # Validate that the subdomain.route1337.com Apache-style certificate exists
  describe file('/data/ssl/certs/A-subdomain.route1337.com.crt') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /CQDVht7yLcothTAN/ } # Check for a random portion of the cert to verify it deployed
    its(:content) { should_not match /mwudXNlcnRydX/ } # Check for a random portion of the cert's ca-bundle to verify it was not added
  end

  # Validate that the subdomain.route1337.com NginX-style certificate exists
  describe file('/data/ssl/certs/N-subdomain.route1337.com.crt') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /CQDVht7yLcothTAN/ } # Check for a random portion of the cert to verify it deployed
    its(:content) { should match /mwudXNlcnRydX/ } # Check for a random portion of the cert's ca-bundle to verify it was added
  end

  # Validate that the subdomain.route1337.com Apache-style ca-bundle exists
  describe file('/data/ssl/certs/A-subdomain.route1337.com.ca-bundle') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /mwudXNlcnRydX/ } # Check for a random portion of the cert's ca-bundle to verify it deployed
    its(:content) { should_not match /CQDVht7yLcothTAN/ } # Check for a random portion of the cert to verify it was not added
  end

  # Validate that the subdomain.route1337.com key exists
  describe file('/data/ssl/keys/subdomain.route1337.com.key') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /f2J5tdNcBYpNFT/ } # Check for a random portion of the key to verify it deployed
  end

  # Validate that the www.route1337.com Apache-style certificate exists
  describe file('/data/ssl/certs/A-www.route1337.com.crt') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /GA1UECAwKTmV3IEp/ } # Check for a random portion of the cert to verify it deployed
    its(:content) { should_not match /mwudXNlcnRydX/ } # Check for a random portion of the cert's ca-bundle to verify it was not added
  end

  # Validate that the www.route1337.com NginX-style certificate exists
  describe file('/data/ssl/certs/N-www.route1337.com.crt') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /GA1UECAwKTmV3IEp/ } # Check for a random portion of the cert to verify it deployed
    its(:content) { should match /mwudXNlcnRydX/ } # Check for a random portion of the cert's ca-bundle to verify it was added
  end

  # Validate that the www.route1337.com Apache-style ca-bundle exists
  describe file('/data/ssl/certs/A-www.route1337.com.ca-bundle') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /mwudXNlcnRydX/ } # Check for a random portion of the cert's ca-bundle to verify it deployed
    its(:content) { should_not match /GA1UECAwKTmV3IEp/ } # Check for a random portion of the cert to verify it was not added
  end

  # Validate that the www.route1337.com key exists
  describe file('/data/ssl/keys/www.route1337.com.key') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /Uuv8ZEMtI84vXhUKoub/ } # Check for a random portion of the key to verify it deployed
  end

  # Validate that the WCARD.route1337.com Apache-style certificate exists
  describe file('/data/ssl/certs/A-WCARD.route1337.com.crt') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /KDBhJbnRlcm5ldCBXa/ } # Check for a random portion of the cert to verify it deployed
    its(:content) { should_not match /mwudXNlcnRydX/ } # Check for a random portion of the cert's ca-bundle to verify it was not added
  end

  # Validate that the WCARD.route1337.com NginX-style certificate exists
  describe file('/data/ssl/certs/N-WCARD.route1337.com.crt') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /KDBhJbnRlcm5ldCBXa/ } # Check for a random portion of the cert to verify it deployed
    its(:content) { should match /mwudXNlcnRydX/ } # Check for a random portion of the cert's ca-bundle to verify it was added
  end

  # Validate that the WCARD.route1337.com Apache-style ca-bundle exists
  describe file('/data/ssl/certs/A-WCARD.route1337.com.ca-bundle') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /mwudXNlcnRydX/ } # Check for a random portion of the cert's ca-bundle to verify it deployed
    its(:content) { should_not match /KDBhJbnRlcm5ldCBXa/ } # Check for a random portion of the cert to verify it was not added
  end

  # Validate that the WCARD.route1337.com key exists
  describe file('/data/ssl/keys/WCARD.route1337.com.key') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /BghYS9V2VOATJQ40iP/ } # Check for a random portion of the key to verify it deployed
  end

  # Validate that the activedirectory.route1337.internal Apache-style certificate exists
  describe file('/data/ssl/certs/A-activedirectory.route1337.internal.crt') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /xKzApBgNVBAMMImFjdG/ } # Check for a random portion of the cert to verify it deployed
    its(:content) { should_not match /mwudXNlcnRydX/ } # Check for a random portion of the cert's ca-bundle to verify it was not added
  end

  # Validate that the activedirectory.route1337.internal NginX-style certificate exists
  describe file('/data/ssl/certs/N-activedirectory.route1337.internal.crt') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /xKzApBgNVBAMMImFjdG/ } # Check for a random portion of the cert to verify it deployed
    its(:content) { should match /mwudXNlcnRydX/ } # Check for a random portion of the cert's ca-bundle to verify it was added
  end

  # Validate that the activedirectory.route1337.internal Apache-style ca-bundle exists
  describe file('/data/ssl/certs/A-activedirectory.route1337.internal.ca-bundle') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /mwudXNlcnRydX/ } # Check for a random portion of the cert's ca-bundle to verify it deployed
    its(:content) { should_not match /xKzApBgNVBAMMImFjdG/ } # Check for a random portion of the cert to verify it was not added
  end

  # Validate that the activedirectory.route1337.internal key exists
  describe file('/data/ssl/keys/activedirectory.route1337.internal.key') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0640 }
    its(:content) { should match /dU5Rxoxu7acoDQMaaZx7c/ } # Check for a random portion of the key to verify it deployed
  end
end