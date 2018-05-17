Changelog
=========

1.4.0
-----

Main:

- fix: do not try to init a cluster when joined (this fixes the case when the
  Consul is erased and reinitialised)
- feat: rename 'name' service property to 'service'
- feat: add config recipe to manage daemon.json
- feat: add tls support
- feat: set detach true for service creation
- feat: allow multiples values for a service option

Tests:

- use .gitlab-ci.yml template [20180208]

Misc:

- docs: update swarm recipe part
- fix: deprecation warning in swarm resource
- fix: workaround a 13.7 nasty chef bug

1.3.0
-----

Main:

- feat: add partial override of unit as default
  + You can override systemd unit of docker in two way:
    - merge (default), configure just the keys you want to add/modify
    - full, replace packaged unit completely
  + WARN: Before this patch, only full was available. By using merge as
    default, this introduces a potential breaking change.
- feat: create auth file for registry attributes
  + Create '/root/.docker/config.json' with authentication info specified
    in 'docker_registry' attributes.
- feat: update pkg & repo info to get latest version
  + Docker repositories and package name change after the 17.05 version.
    This patch updates the default info and allows a better configuration.
- feat: monkey patches docker to fix ip\_address bug
  + ip\_address value is not returned correctly by load\_current\_value.
    This causes the resource to run each time, destroying and restarting
    containers with fixed ip at each run.
  + This patch monkey-patches docker cookbook to fix this bug. When the
    bug will be resolved upstream, a warning will be outputted.

Misc:

- fix: use new\_resource prefix in swarm resource

1.2.0
-----

Main:

- feat(swarm): get managers from search
  + Nodes are separated in two roles, managers and workers:
    - managers are found by a search on a role
    - workers are the other nodes
  + Upload to consul both manager and worker token
- feat: remove the need to define an initiator
  + Before this version, an initiator would have to be defined to perform all
    swarm admin action like init, network, etc. By using Consul and its
    distributed lock feature, we remove the need to set an initiator: admin
    ops can be done by any manager
  + Also fixes many other problems, basically because the
    initiator was a SPOF:
    - the rejoin of a previously initiator (which was trying to recreate a
      cluster)
    - the join of any node if the initiator was down (because all nodes
      tried to join by contacting the initiator)
- refactor: add swarm in default, refact resources
  + Set swarm recipe in default recipe, before calling docker cookbook
    resources. Add a flag "enabled?" (default to false) for stand-alone
    nodes.
- remove network resource as it can be done by docker\_network.
- fix against latest version of diplomat (consul gem)
- fix chef 13 when package\_retries is nil (default)
- refactor: move swarm config in consul to swarm sub-key
- fix #1: wait for docker to be ready after start it
- fix: merge init\_opts with join\_opts for swarm init

Tests:

- use most recent image and add build\_pull
- fix consul config, improve errors output
- reduce wait times and scaling requirement
- add info while waiting, betting balancing
- use .gitlab-ci.yml template [20170731]
- use 3 manager nodes and 1 worker
- check each node status in the cluster
- separate test of standalone suite from swarm
- check redis image after rebalancing

Misc:

- handover maintainance to Make.org, fix metadata
- style: fix rubocop offenses: %i stuff
- fix: move consul dependency to tests
- fix(gemfile): add linter, force molinillo version
- refactor: change wording, master to manager
- style: fix indentation in .kitchen.yml
- style(rubocop): fix heredoc delimiters
- docs: use karma for git format in contributing

1.1.0
-----

Add swarm creation support and service deployment by using custom resources

1.0.1
-----

- Fix versionning of package

1.0.0
-----

- Initial version for Centos 7
