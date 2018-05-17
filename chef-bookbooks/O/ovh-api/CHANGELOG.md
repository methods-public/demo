Changelog
=========

2.3.0
-----

Main:

- feat(backup): add recipe for ovh backup space
  + you can active dedicated "FTP" backup space
  + mount it if you use NFS or CIFS

Tests:

- use .gitlab-ci.yml template [20170731]
- add build\_pull for kitchen (get latest image)

Misc:

- fix license in metadata, set correct chef\_version
- style(rubocop): fix wrong HeredocDelimiterNaming
- use karma for git format in contributing
- chore: set 2018 in copyright notice

2.2.0
-----

Main:

- Handover maintenance to Make.org
- Add documentation on firewall rules
- Add new cases of vrack ifaces (compatible with more servers)
- Add support for cloud, add server type in Ohai

Tests:

- Tests work with shared runners!
- Use latest template for .gitlab-ci.yml [20170405]
- Set always\_update\_cookbooks in provisioner

Misc:

- Fix misc foodcritic and rubocop offenses

2.1.0
-----

Main:

- Fix idempotence in firewall rules containing port configurations

2.0.0
-----

Main:

- Work with ohai cookbook >= 4.x

Tests:

- Work with webmock >= 2.x
- Strengthen gitlab-ci tests
  + remove previous container correctly
  + add silence option to curl calls
  + destroy containers even if tests fail
- Deactivate kitchen-docker\_cli preparation (use image directly)

1.2.0
-----

Main:

- Create OVH firewall for the server if needed and wait for it (55s max)

Tests:

- Switch kitchen driver to docker\_cli
- Remove all platforms but centos and use prepared docker image
- Define Continuous Integration configuration with gitlab-ci

Misc:

- Fix rubocop offenses
- Rename CHANGELOG -> CHANGELOG.md and fix markdown
- Fix Gemfile, need k-docker\_cli instead of k-docker

1.1.0
-----

Main:

- Fix service\_name detection, check all ips, not just eth0
- Create an Ohai plugin to add OVH information in node['ovh']:
  * service\_name, service name as defined in the interface
  * primary\_ip, static ip attributed by OVH
  * primary\_iface, network interface on which the primary ip is defined
  * vrack\_iface, network interface reserved for vrack
  * hardware, from /specifications/hardware
  Install it by adding recipe['ovh-api::ohai'] in your runlist

Minor:

- Standardize docker images among cookbooks
  * Create an universal image for centos/debian/ubuntu
- Fix all rubocop offenses

1.0.0
-----

- Initial version with firewall configuration (/ip/firewall)
- Should work almost everywhere but tested on Centos 7, Debian 8 and
  Ubundu 1404
