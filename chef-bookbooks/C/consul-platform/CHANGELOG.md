Changelog
=========

1.1.0
-----

Main:

- BREAKING CHANGE RELEASE
- Set default version to 0.8.3
- Use config file instead of cli options for configuration
- Handover maintainance to Make.org
- Fix package\_retries utilisation (for Chef 13)

Tests:

- Use latest template for .gitlab-ci.yml [20170529] (support shared runner)
- Fix destroy in CI tests, remove suite order constraint
- Set build\_pull to true (always pull latest images)
- Add a client with its tests, remame nodes, move config from role
- Reduce max wait in tests

Misc:

- Fix foodcritic offenses in metadata
- Fix misc rubocop offenses (mostly %i stuff)
- Simplify tests and adapt them to 0.8.3, remove deprecated RPC service

1.0.0
-----

- Initial version working with consul 0.7.2.
