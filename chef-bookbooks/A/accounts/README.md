# accounts cookbook

This cookbook combines system account management for different services under a single interface.
It currently manages users, groups and the associate ssh and sudo settings.

It provides the following definitions:

- account

- agroup

It uses the cookbook files directory for all the files used for each account (ssh, etc.), which could be a symlink, 
git submodule or however you would like to manage that data.

# Requirements

# Usage

  include_recipe "accounts"

  # optionally set node[:accounts][:cookbook] to the cookbook that contains the config files

  account "role" do
    uid "700"
    account_type "role"
    comment "Role Account"
    ssh false
    sudo true
  end
  
  agroup "users" do
    gid "100"
    sudo true
  end

# Attributes

# Recipes

