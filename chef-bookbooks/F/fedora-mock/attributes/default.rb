# automatically enable EPEL for non-Fedora based distributions because this is
#  typically the default use case however this is left as an attribute in case
#  of security concerns of automatically enabling another software repository
#  or if the package can be sourced from a repo already enabled on the server
default['fedora-mock']['enable-epel'] = !(node['platform'] == 'fedora')

# fedora-mock plugins
default['fedora-mock']['plugins'] = {}

# fedora-mock users
default['fedora-mock']['users'] = {}
