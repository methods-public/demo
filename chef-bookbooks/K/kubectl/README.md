# kubectl

Installs the [kubectl](https://kubernetes.io/docs/user-guide/kubectl-overview) tool.

# Attributes

All of the following attributes are under the `node[:kubectl]` key. For example:

        node['kubectl']['version']

* `version` - Can be either `latest` or a version like `1.8.0`. Defaults to `latest`
* `download_base_url` - Base URL from which to download the release.
* `install_prefix` - Directory in which to install the binary. Defaults to `/usr/local/bin` on UNIX-like systems, and `C:\Program Files` on Microsoft Windows.

# Recipes

All recipes assume the default recipe has been applied.

## Default

Install `kubectl` at the `version` and `install_prefix` specified. If there is already a `kubectl` binary located at the `install_prefix`, then the version is checked. If the version of the installed `kubectl` matches the desired version, then nothing is done. Any other version is replaced with the requested version of kubectl. This means that a _more recent_ version of `kubectl` can be replaced by an _older_ one.
