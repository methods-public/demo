Changelog
=========

2.3.0
-----

Main:

- feat: improve backup script to facilitate restore
  + Change backup structure to make restores easier to do
  + Create backup in tmp then move it to backup location (better when
    back upping on a slow distant storage)
  + Clear snapshot at the end of the backup
  + Add check on backup size to verify if the backup actually worked
  + Reformat backup script to be more readable
- feat: add version management for java package
- feat: set default Cassandra version to 3.11.2

Tests:

- include .gitlab-ci.yml from test-cookbook
- move to product\_name & install\_strategy

Misc:

- style(rubocop): fix "enable after disable" offense
- chore: add 2018 to copyright notice

2.2.0
-----

Main:

- feat(backup): create an unique compressed archive

Tests:

- test: use package\_retries on gem install to prevent temporarily failure

2.1.0
-----

Manual Migration Needed:

- if you use default data dir configuration:
  + stop Cassandra, move all data from $CASSANDRA\_HOME/data to
    /var/opt/cassandra
  + remove $CASSANDRA\_HOME/data
  + launch chef with latest cookbook version

Main:

- feat: set default version to 3.11.1
- feat: add support for a Prometheus exporter
  + Activate with an attribute the capability to have a file Prometheus
    exporter for Cassandra. By combining it with "node exporter", you can
    export Cassandra metrics to Prometheus.
- feat: move default data dir to /var/opt/cassandra
- feat: install backup script through backup recipe

Tests:

- test(gitlab): up gitlab-ci.yml to 20170731
- test: increase exporter timeout to 30\*5s
- test: add tests for backup recipe & script

Misc:

- docs(supermarket): fix issues url
- chore: add foodcritic & rubocop in Gemfile
- docs: add backup recipe in README

2.0.0
-----

Main:

- handover maintainance to Make.org
- switch to Apache 3.10 (was datastax dsc30)
- manage all configuration files & simplify config merge with upstream default

Fixes:

- chef13: use default package retries correctly
- search: remove need to be in searched role

Tests:

- use .gitlab-ci.yml template [20170529]
- set build\_pull true, use sbernard image
- add a 3rd node (true minimum setup)
- add tests on service (running & enabled)
- config: add tests on configuration files
- simplify kitchen.yml

Misc:

- rubocop: (%i stuff) & up kitchen\_command
- foodcritic: FC005 on install
- search: clarify seeds definition
- docs: use karma for git format in contributing

1.0.0
-----

- Initial version
