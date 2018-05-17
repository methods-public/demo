Changelog
=========

2.0.0
-----

Main:

- Require Storm > 1.0.0 (because of HA, nimbus.host is no longer valid)
- Configure nimbus HA by allowing multiple nimbus (with n\_of\_nimbus key)
- Fix default config for Storm > 1.0.0
- Fetch log4j2 default config directly from github
- Do not wait anymore after (re)starting a service

Test:

- Strengthen tests: test all nodes and check deactivated services
- Smart sleeps to wait services to be up

Misc:

- Improve documentation (better explanation of search, add HA, etc.)

1.5.0
-----

Main:

- Use Storm 1.0.1 by default
- Fix invalid check on cluster size
- Use Continuous Integration with gitlab-ci

Misc:

- Fix Gemfile, need k-docker\_cli instead of k-docker
- Fix the too long line in kitchen\_sandbox
- Rename CHANGELOG -> CHANGELOG.md and fix markdown

1.4.0
-----

- Fix: config could contain ruby/chef -specific yaml
- Make Systemd unit path configurable, default is now "/etc/systemd/system"

1.3.0
-----

Main:

- Rename recipes containing '-' in their name (small breaking change):
  + create-user -> create\_user
  + systemd-service -> systemd\_service

Test:

- Switch to docker\_cli, use prepared docker image
  + Switch kitchen driver from docker to docker\_cli
  + Use sbernard/centos-systemd-kitchen image instead of bare centos
  + Remove privileged mode :)
  + Remove some useless monkey patching
  + Use loops for suites generation
  + Remove dnsdock, use docker DNS (docker >= 1.10)
  + Use "kitchen" network, create it if needed

Misc:

- Fix rubocop offenses
- Use specific names for resources to avoid cloning
- Improve documentation, search config, etc.

1.2.0
-----

Main:

- Use storm 0.10.0 by default
- Generate config in 2 steps: can use chef variables in erb style

Fixes:

- Fix dirty yaml of nested structure for storm.yaml
- Fix topology launch: create a link from storm.home/logs to log\_dir
- Fix auto-restart and also monitor log4j2 files
- Fix: apply STORM-945 in default log4j configuration

Test:

- Rationalize docker provision to limit images

Packaging:

- Reorganize README:
  + Move changelog from README to CHANGELOG
  + Move contribution guide to CONTRIBUTING.md
  + Reorder README, fix Gemfile missing
- Add Apache 2 license file
- Add missing chefignore

1.1.0
-----

- Strengthen tests reliability by sleeping after a Storm service is launch
- Dependencies use supermarket, switch to zookeeper-platform

1.0.1
-----

- Cleaning, use java-1.8.0-openjdk-headless as default java package

1.0.0
-----

- Initial version with Centos 7 support
