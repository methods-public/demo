# helm

Installs the [helm](https://github.com/kubernetes/helm) tool.

# Attributes

All of the following attributes are under the `node[:helm]` key. For example:

        node['helm']['version']

* `version` - Can be either `latest` or a version like `2.6.2`. Defaults to `latest`
* `download_base_url` - Base URL from which to download the release.
* `install_prefix` - Directory in which to install the binary. Defaults to `/usr/local/bin` on UNIX-like systems, and `C:\Program Files` on Microsoft Windows.

# Recipes

All recipes assume the default recipe has been applied.

## Default

Install `helm` at the `version` and `install_prefix` specified. If there is already a `helm` binary located at the `install_prefix`, then the version is checked. If the version of the installed `helm` matches the desired version, then nothing is done. Any other version is replaced with the requested version of helm. This means that a _more recent_ version of `helm` can be replaced by an _older_ one.
