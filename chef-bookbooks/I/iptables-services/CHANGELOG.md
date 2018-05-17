Changelog
=========

2.2.0
-----

Main:

- feat: add "undefined" rule, used for custom chain
  + If you want to create a custom chain but you don't want to manage it
    because another program will do it, use "undefined" as rule set.
- fix: remove fixed version of iptables package
- fix: add cluster-search dependency in metadata

2.1.0
-----

Main:

- feat: add group, to duplicate rules for each member and deal with clusters
  more easily.

Tests:

- replace deprecated require\_chef\_omnibus
- include .gitlab-ci.yml from test-cookbook

2.0.0
-----

Main:

- feat: major rewrite with new philosophy
  + This idea is to be able to select to which tables and chains we want to
    enforce a configuration, and let the others be managed by another
    programs.
  + The main use-case is to cohabit with Docker (and mostly Docker Swarm)
    without having to rewrite every rules (and also because Swarm without
    iptables support does not really work). Typically, we will define
    filter/INPUT and filter/DOCKER-USER and let Docker manages the rest.
  + Also, we configure the iptables service to save on stop and restart so
    we keep rules defined manually (or by other programs).
- feat: can auto-update package (default)

Tests:

- add a second interface to facilitate tests

1.1.0
-----

Main:

- fix: saved rules were not correctly ordered
- fix: "reload" ip[6]tables after service starts

Misc:

- style(rubocop): fix heredoc delimiter

1.0.0
-----

- Initial version with Centos 7 support, iptables and ip6tables
