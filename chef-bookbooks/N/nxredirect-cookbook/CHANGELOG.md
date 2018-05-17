Changelog
=========

1.2.0
-----

Main:

- feat: can select erlang version, latest by default
- fix(chef13): use default package retries correctly

Tests:

- test: use .gitlab-ci.yml template [20170731]
- test: set build\_pull to get latest image

Misc:

- docs: use karma for git format in contributing
- chore: fix licence format

1.1.0
-----

Main:

- Handover maintenance to Make.org

Tests:

- Add a nsupdate use case to strengthen tests
- Set always\_update\_cookbooks: true in provisioner
- Use latest template for .gitlab-ci.yml [20170405]
- Remove the need of docker network kitchen
- Fix test on noop (change of systemd output format)

Misc:

- Fix rubocop and foodcritic offenses

1.0.0
-----

- Initial version, use unreleased build 2967352.
