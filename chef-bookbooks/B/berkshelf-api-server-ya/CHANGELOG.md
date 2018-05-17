berkshelf-api-server-ya CHANGELOG
=================================

0.3.8
-----
- refactoring.

0.3.7
-----
- updates the nginx version.

0.3.6
-----
- holds dependent cookbooks' version, because the `berkshelf-api-server` cookbook is deprecated.
- adds the workaround: ohai >= 4.0.0 throws nillclass on `node['ohai']['plugin_path']`

0.3.5
-----
- Cleanup for FoodCritic and RuboCop.

0.3.3
-----
- add cache file clear feature.

0.3.2
-----
- add some attributes for chef_gem resource.

0.3.1
-----
- Improvement of SSL server key deployment's notification. 

0.3.0
-----
- Vault item scan improvement for nested hash.

0.2.0
-----
- SSL server key deployment by the Chef Vault.
- Endpoints access user's private key deployment by the Chef Vault.

0.1.0
-----
- Application server bind address setting.
- HTTPS configurations.

