Changelog
=========

1.5.0
-----

Main:

- feat: make data bag name for users configurable

Tests:

- adapt to latest version of users cookbook
- include .gitlab-ci.yml from test-cookbook
- replace deprecated require\_chef\_omnibus

1.4.0
-----

Main:

- fix: use delayed action instead of NOP resource

Tests:

- use .gitlab-ci.yml template [20170731]

Misc:

- docs: use karma for git format in contributing

1.3.0
-----

Main:

- fix: do not expect a gid on a whitelisted group
  aka you can modify a system(d) group without having to define its gid
- fix: use true attribute instead of resource name
  aka you can define a true name like "create foo" for your resources
- fix: replace ruby\_block by a not-updated resource
  aka only one resource is always updated: log(check)

Tests:

-  use .gitlab-ci.yml template [20170529]

1.2.0
-----

Main:

- Handover maintainance to Make.org
- Set minimum chef\_version to 12.14

Tests:

- Use latest template for .gitlab-ci.yml [20170405]k
- Update dependencies in tests (cookbook & images)

Misc:

- Fix misc rubocop offenses (%i and %w stuff)

1.1.0
-----

- Add create (users) recipe: use users cookbook to create groups and their
  associated users. Enable by default on sysadmin group.

1.0.0
-----

- Initial version, tested on Centos 7
