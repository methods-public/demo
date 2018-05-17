#!/usr/bin/env bash

# https://dcos.io/docs/1.8/administration/installing/custom/uninstall/
# https://dcos.io/docs/1.8/administration/installing/custom/uninstall/

PATH=.:/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin:`dirname $0`

install_dir=<%= File.dirname(node['dcos-grid']['bootstrap']['genconf_dir']) %>
release_script_name=<%= node['dcos-grid']['dcos_release_script_name'] %>

echo '[WARN] DC/OS does NOT support uninstall yet!'
echo 'See https://dcos.io/docs/1.8/administration/installing/custom/uninstall/'

usage() {
  echo 'Usage: uninstall.sh [-y] [-h]'
  echo 'This script uninstalls DC/OS.'
  echo
  echo "Options:"
  echo "  -h: this help."
  echo "  -y: always yes."
  echo
}

execute() {
  CMD=$1
  echo "[`date '+%Y-%m-%d %H:%M:%S %:z'`] Command: $CMD"
  [ "$why_run" = 1 ] || eval $CMD
}

ARGS="$@"
# Validation
while getopts 'yh' OPT; do
  case $OPT in
    'y' )
      always_yes=1
      ;;
    'h' )
      usage
      exit 0
      ;;
    '?' )
      usage
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))

echo 'DC/OS on this node will be uninstalled.'
while true; do
  [ "$always_yes" = 1 ] && break

  echo -n 'Continue the uninstall? [y/N]: '
  read answer
  case $answer in
    'y' | 'yes' )
      break
      ;;
    '' | 'n' | 'no' )
      echo 'Uninstall was aborted by user.'
      exit 0
      ;;
    * )
      ;;
  esac
done

sudo='sudo'
[ `whoami` = 'root' ] && sudo=''

# for Bootstrap node
if ls $install_dir | grep 'dcos-genconf.*.tar' > /dev/null 2>&1; then
  execute "$sudo rm ${install_dir}/dcos-genconf.*.tar"
fi

if ls $install_dir | grep $release_script_name > /dev/null 2>&1; then
  execute "$sudo rm ${install_dir}/${release_script_name}"
fi

# for Master and Agent nodes
pkgpanda=/opt/mesosphere/bin/pkgpanda
if [ -e "$pkgpanda" ]; then
  echo 'Uninstalling DC/OS packages...'
  execute "$sudo -i $pkgpanda uninstall"
fi

if [ -e /opt/mesosphere ]; then
  echo 'Remove /opt/mesosphere and /etc/mesosphere ...'
  execute "$sudo rm -rf /opt/mesosphere /etc/mesosphere"
fi

if [ -e /tmp/dcos ]; then
  echo 'Remove /tmp/dcos ...'
  execute "$sudo rm -rf /tmp/dcos"
fi

echo 'Uninstalled DC/OS successfully.'
