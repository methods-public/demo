deploy-user cookbook
===============================

Note this version of the cookbook will be replaced with an entirely new version
as a major version bump. It is here for legacy reasons.

Usage
-----

This cookbook will create a deploy user if there is the appropriate
data bag item for a user e.g. `data_bags/users/deploy.json`. Note since the
private key is sensitive, it should be an encrypted data bag.

```json
{
  "id": "deploy",
  "groups": ["deploy"],
  "ssh_private_key": "-----BEGIN RSA PRIVATE KEY----- ...",
  "ssh_public_key": "ssh-rsa AAAA... comment"
}
```

It will also load the appropriate known SSH host keys to the global
`/etc/sshd/ssh_known_hosts` so that these SSH hosts will already be trusted at
deployment time to avoid interactivity problems. The default will add
github.com's host key, but can be configured via
`node['capistrano']['known_hosts']`

This attribute will take either an array of SSH host domains (which ssh_known_hosts
cookbook will look up the SSH host key for, or a Hash of `{host=>host key}`.

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

Supermarket share
-----------------

[stove](http://sethvargo.github.io/stove/) is used to create git tags and
publish the cookbook on supermarket.chef.io.

To tag/publish you need to be a contributor to the cookbook on Supermarket and
run:

```
$ stove login --username <your username> --key ~/.chef/<your username>.pem
$ rake publish
```

It will take the version defined in metadata.rb, create a tag, and push the
cookbook to http://supermarket.chef.io/cookbooks/deploy-user


License and Authors
-------------------
- Author:: Andy Thompson

```text
Copyright:: 2014-2016 The Inviqa Group Ltd

See LICENSE file
```
