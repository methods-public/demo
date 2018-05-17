[![Build Status](https://travis-ci.org/simplare-cookbooks/no-ip.svg?branch=master)](https://travis-ci.org/simplare-cookbooks/no-ip)
[![Chef cookbook](https://img.shields.io/cookbook/v/no-ip.svg?maxAge=2592000)](https://supermarket.chef.io/cookbooks/no-ip)
[![Code Climate](https://codeclimate.com/github/simplare-cookbooks/no-ip/badges/gpa.svg)](https://codeclimate.com/github/simplare-cookbooks/no-ip)
[![Test Coverage](https://codeclimate.com/github/simplare-cookbooks/no-ip/badges/coverage.svg)](https://codeclimate.com/github/simplare-cookbooks/no-ip/coverage)

# No-IP Cookbook

This cookbook installs the No-IP agent on a node, allowing you to access the node using a dynamic DNS name.

## Supported Platforms

- CentOS 7.2
- Ubuntu 14.04

## Attributes

- `interval` - *Integer* - Number of seconds between updates
- `username` - *String* - The username at noip.com

## Encrypted data bags
- `[:credentials]['noip']['password']` - *String* - The password at noip.com

## Usage

Include `no-ip::default` in your run list. You need to specify the username and password
for the noip.com account you want to use.

Create the password using Chef Vault:

    $ knife vault create credentials noip \
            '{"password":"my-secret-password"}' \
            -A "admin1,admin2" \
            -S "name:my-node-name"

This would set the password to `my-secret-password`, allowing *admin1* and *admin2* to see the password and make it available to the node with the name *my-node-name*. Adjust these values to your liking.
