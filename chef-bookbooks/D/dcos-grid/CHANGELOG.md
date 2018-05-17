dcos-grid CHANGELOG
===================

0.5.4
-----
- improves the CLI setup script.

0.5.3
-----
- adds the `dcos-grid::gp-node` recipe.
- improves the Bootstrap node setup script.

0.5.2
-----
- bug fix: Bootstrap node's nginx restart command.
- adds the `['dcos-grid']['cloud-config']['timezone']` attribute.

0.5.1
-----
- adds `DC/OS in LXD` setup support.
- updates documents.

0.5.0
-----
- improves CLI installation.
- adds sha256 checksum verification of the downloaded DC/OS artifacts.

0.4.9
-----
- adds `dcos-grid::universe-server` recipe.
- refactoring.

0.4.8
-----
- adds `['dcos-grid']['dcos_release_script_name']` attribute.
- adds `dcos-grid::universe-build-env` recipe.

0.4.7
-----
- improves the bootstrap node upgrade script.

0.4.6
-----
- bug fix.

0.4.5
-----
- refactors the upgrade scripts.

0.4.4
-----
- improves the upgrade scripts.

0.4.3
-----
- refactoring.
- updates `docker-grid` cookbook dependency.
- updates `['dcos-grid']['dcos_cli_release_url']` default value.
- adds `['dcos-grid']['dcos_cli_upgrade']` attribute.
- adds node upgrade scripts.

0.4.2
-----
- bug fix: generating genconf/config.yaml

0.4.1
-----
- updates `docker-grid` cookbook dependency.
- adds `['dcos-grid']['bootstrap']['config']['telemetry_enabled']` attribute's default value `'false'`,

0.4.0
-----
- separates the `docker-grid` cookbook.

0.3.5
-----
- refactoring.
- bug fix.

0.3.4
-----
- adds some attributes for Docker daemon's execution option.

0.3.3
-----
- improves configuration validation.

0.3.2
-----
- adds `['dcos-grid']['bootstrap']['config']['master_discovery']` default value.
- adds some `['dcos-grid']['bootstrap']['config']['oauth_*']` attributes' default values.

0.3.1
-----
- adds some attributes of APT and YUM repositories' settings.
- adds docker-engine version lock feature (by apt-pinning) on Ubuntu.

0.3.0
-----
- adds Ubuntu (>= 16.04) support (Experimental).
- adds `dcos-grid::cli` recipe.

0.2.0
-----
- adds some attributes for the generation of cloud-config.yaml
- improves the Markdown formatting of READEME.md

0.1.0
-----
- Initial release of dcos-grid
