Hem Cookbook
============

Install [https://github.com/inviqa/hem](hem) into a Redhat/Centos or Debian/Ubuntu server.

Supported Platforms
-------------------

* Redhat 6.7+
* Centos 6.7+
* Ubuntu 14.04+

Recipes
-------

### hem::default

Set up the correct repositories and install hem.
Hem dependencies `git` and `vagrant` will be installed by their respective cookbooks.

### hem::environment

Set up a /etc/profile.d/ script that adds the hem directory to the path and sets hem to run commands in local mode
rather than requiring a VM.



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
cookbook to http://supermarket.chef.io/cookbooks/hem


License and Authors
-------------------
- Authors:: Kieren Evans
            Pete McFarlane
            Mike Barrett

```text
Copyright:: 2016 The Inviqa Group Ltd

See LICENSE file
```
