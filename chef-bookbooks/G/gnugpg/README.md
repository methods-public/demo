# gnugpg Cookbook
Cookbook to deploy gnugpg - a complete and free implementation of the OpenPGP standard. 

[![Gem Version](https://badge.fury.io/rb/kitchen-vagrant.svg)](http://badge.fury.io/rb/kitchen-vagrant)
[![Build Status](https://travis-ci.org/rodel-talampas/gnugpg.svg?branch=master)](https://travis-ci.org/rodel-talampas/gnugpg)

## Requirements

### Windows Server

There are two things to override among `gnugpg` attributes

`node['gnugpg']['keys']['file']` - this defaults to `c:\tmp` directory

`node['gnugpg']['temp']['directory']` - this is an array of GPG keys that you want to install

There is a need to create a wrapper recipe to copy your GPG keys into the target host. The `gnugpg` cookbook expects the key or keys to be inside `node['gnugpg']['temp']['directory']` directory.

This cookbook needs to be included after the wrapper has been called. 

### Chef

- Chef 12.7+

### Platform

- CentOS, Red Hat - (to support on next version)    
- Amazon Linux, Amazon - (to support on next version)
- Windows Server

## Tested on:

- Windows Server 2012 Standard R2

## Usage

Use the following code snippets.

#### Examples (Windows)
```
gnugpg_override.rb
---------------------
override['gnugpg']['keys']['file'] = ['gpg-secret-key.asc']
override['gnugpg']['temp']['directory'] = 'c:\\temp'


gnugpg_wrapper_recipe.rb
---------------------
node['gnugpg']['keys']['file'].each do |key|
  template "#{node['gnugpg']['temp']['directory']}\\#{key}" do
    source "gpg/#{key}.erb"
  end
end

include_recipe 'gnugpg::default'
```

# Authors
Author:: Rodel M. Talampas
