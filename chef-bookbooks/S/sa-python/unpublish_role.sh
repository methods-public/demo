#!/bin/sh

CURRENT_ROLE=`cat metadata.rb | grep "name '" | awk -F"'" '$0=$2'`
VERSION=${1-0.0.2}
knife cookbook site unshare "${CURRENT_ROLE}/versions/${VERSION}"  -c ~/.chef/knife_sa.rb -VV
