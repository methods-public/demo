# gitlab-grid CHANGELOG

0.1.6
-----
- improves CA certificates and server key pair deployment.

0.1.5
-----
- refactoring.

0.1.4
-----
- includes the `ssl_cert::server_key_pairs` and `ssl_cert::ca_certs` recipes automatically.

0.1.3
-----
- adds the `gitlab-grid::docker-compose` recipe.

0.1.2
-----
- improves service management.
- adds the feature for container registry setup.
- adds the `['gitlab-grid']['ssl_cert']['registry']['reuse_gitlab_cn']` attribute.
- adds the `gitlab-grid::runner-docker-compose` recipe.

0.1.1
-----
- improves the `gitlab-grid::server` recipe.
- modifies directory permissions.

0.1.0
-----
- Initial release of gitlab-grid
