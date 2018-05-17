#!/usr/bin/env bash

# Set environment variable CHEFDK_VERSION to override the default version of chefdk

echo "Starting chefdk_bootstrap_nord bootstrap..."

echo "Setting up proxy environment variables..."
export http_proxy=http://webproxysea.nordstrom.net:8181
export https_proxy=$http_proxy
export no_proxy='localhost,127.0.0.1,nordstrom.net'

# Send these attributes into the bootstrap to be passed into chef-client
# CHEFDK_BOOTSTRAP_JSON_ATTRIBUTES="https://git.nordstrom.net/projects/CHF/repos/chefdk_bootstrap_nord/browse/attributes.json?raw"
CHEFDK_BOOTSTRAP_JSON_ATTRIBUTES="https://git.nordstrom.net/projects/CHF/repos/chefdk_bootstrap_nord/browse?at=refs%2Fheads%2FPCM-892/attributes.json?raw"
echo ${CHEFDK_BOOTSTRAP_JSON_ATTRIBUTES}
[ -z "$CHEFDK_VERSION" ] && CHEFDK_VERSION="2.4.17"

echo "Starting chefdk_bootstrap..."
echo attributes
echo ${CHEFDK_BOOTSTRAP_JSON_ATTRIBUTES}

ruby -e "$(curl https://raw.githubusercontent.com/Nordstrom/chefdk_bootstrap/master/bootstrap.rb)" - --json-attributes $CHEFDK_BOOTSTRAP_JSON_ATTRIBUTES --version $CHEFDK_VERSION

# Check to see if the .chef folder exists and already has files in it
if [[ -d ~/.chef && "$(ls -A ~/.chef)" ]]; then
  echo "Chef configuration appears to already be set up."
else
  echo "Configuring chef..."
  echo "(You may be prompted for your password to access git.nordstrom.net)"
  git clone https://$USER@git.nordstrom.net/scm/chf/dotchef.git ~/.chef
fi
