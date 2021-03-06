Changelog
=========

1.13.0
------

Main:

- fix #3: unable to create reverse zones
- feat: add support to configure start-up options
- chore: remove extra empty lines in zone template
  + WARNING: this may change zone template and thus discard all current
    dynamic entries

Tests:

- use product\_name and install\_strategy to replace deprecated
  require\_chef\_omnibus
- include .gitlab-ci.yml from test-cookbook

Misc:

- style(foodcritic): remove use\_inline\_resource
- style(rubocop): disable short params name rule
- chore: add 2018 to copyright notice

1.12.0
------

Main:

- feat: add statistics-channels in named.conf

Misc:

- style(rubocop): fix heredoc delimiters offenses
- docs: use karma for git format in contributing
- chore: add foodcritic & rubocop in Gemfile

1.11.0
------

Main:

- fix #2: use (configurable) full path for rndc bin

Tests:

- use .gitlab-ci.yml template [20170731]

1.10.0
------

Main:

- fix: correct use of package\_retries when nil, which is default (chef 13)
- fix: allow forward zones to be defined (#1)

Tests:

- set template for .gitlab-ci.yml [20170529]

Misc:

- refactor: replace 'bind-ddns' by cookbook\_name


1.9.0
-----

Main:

- Handover maintainance to Make.org

Tests:

- Use latest template for .gitlab-ci.yml [20170405]
- Add build\_pull for kitchen driver, reorganise opts
- Fix tests when resolv contains an IPV6 with iface

Misc:

- Add chef\_version, fix license in metadata
- Fix rubocop offenses (mostly %i with [])
- Disable FC085 for the moment

1.8.0
-----

Main:

- Fix output of category (logging) in named.conf
- Use cookbook\_name "macro" everywhere

Tests:

- Use latest gitlab-ci config (20170117)
- Fix cleaning of test instances on CI

1.7.0
-----

Main:

- Add port option for nsupdate resource

Tests:

- Use latest gitlab-ci config (20161220)
- Set always\_update\_cookbooks to avoid old berk lock

1.6.0
-----

Main:

- Refactor default provider to manage correctly non-A entries
- Fix #1: nsupdate fails during first run on server

Tests:

- Use latest gitlab-ci.yml template (20160914)
- Fix test cleaning, make verify independant
+ Refactor tests, use dig, be more consistent

Misc:

- Fix rubocop offenses (from new versions)

1.5.0
-----

Main:

- Fix provider: use nsupdate delete instead of del
  'delete' is valid on all version whereas 'del' is only valid since 9.9,
  make it compatible Centos 6

Tests:

- Use Continuous Integration with gitlab-ci, use templated config
- Set skip\_preparation to true for kitchen-docker\_cli
- Set seccomp to unconfined for docker run
- Add option to retry package installation
- Set forwarders for tests
- Use nameservers from host to populate test config

Misc:

- Fix rubocop issue in bindserver\_spec.rb
- Fix rubocop offense on file mode
- Write changelog in markdown

1.4.0
-----

Main:

- Can use specific options for clients or servers, to allow clients and
  servers to share the same role
  + Add an init recipe which initialize the configuration correctly
  + Modify default to choose between client and server recipe
  + client specific configurations should be in 'client-config' and
    servers in 'server-config'
  + the servers should be defined with 'servers' key
  + backward compatibility is not broken

- Switch to docker\_cli, use prepared docker image
  + Switch kitchen driver from docker to docker\_cli
  + Use sbernard/centos-systemd-kitchen image instead of bare centos
  + Remove privileged mode :)
  + Remove some now useless monkey patching
  + Fix a typo in kitchen\_command, fixing kitchen create command

Misc:

- Fix default options not merged with user attributes
- Improve documentation, explain resource attributes and specific
  configurations
- Better tests, to test specific option behavior
- Fix all rubocop offenses
  + In particular, package-client recipe is renamed to package\_client

1.3.1
-----

- Fix deprecated behavior (using nil as argument for a default resource)

1.3.0
-----

- Use lazy to simplify the definition of template "#{filepath}.erb"
- Small cleanup of default provider & resource, key info are required
- Fix idempotency by removing the block hack used to run the resource
- Add a test case on :delete for default provider

1.2.0
-----

- Add option for secondary servers in resolv.conf
- Reorganize README:
  + Move changelog from README to CHANGELOG
  + Move contribution guide to CONTRIBUTING.md
  + Reorder README, fix Gemfile missing
- Add Apache 2 license file

1.1.0
-----

- Fix failed run when a zone is reloaded while named is stopped
- Fix failed run when an interface name is used for its ip and this ip is
  fetched during the same run
- Fix failed run when a zone is modified while named is stopped
- Remove useless field 'hmac' in resource and provider

1.0.1
-----

- Fix default hostmaster email

1.0.0
-----

- Initial version with Centos 7 support
