# minikube

Installs the [minikube](https://github.com/kubernetes/minikube/) tool.

# Attributes

All of the following attributes are under the `node[:minikube]` key. For example:

        node['minikube']['version']

* `version` - Can be either `latest` or a version like `0.22.2`. Defaults to `latest`
* `download_base_url` - Base URL from which to download the release.
* `install_prefix` - Directory in which to install the binary. Defaults to `/usr/local/bin` on UNIX-like systems, and `C:\Program Files` on Microsoft Windows.

# Recipes

All recipes assume the default recipe has been applied.

## Default

Install `minikube` at the `version` and `install_prefix` specified. If there is already a `minikube` binary located at the `install_prefix`, then the version is checked. If the version of the installed `minikube` matches the desired version, then nothing is done. Any other version is replaced with the requested version of minikube. This means that a _more recent_ version of `minikube` can be replaced by an _older_ one.