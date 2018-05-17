#!/usr/bin/env bash

# https://dcos.io/docs/1.8/administration/installing/custom/advanced/
# https://dcos.io/docs/1.7/administration/installing/custom/advanced/

PATH=.:/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin:`dirname $0`

usage() {
  echo 'Usage: node_setup.sh [-y] [-W] [-h] {master,agent,slave,agent_public,slave_public}'
  echo 'This script sets up DC/OS master or agent node.'
  echo
  echo "Options:"
  echo "  -h: this help."
  echo "  -y: always yes."
  echo "  -W: why-run mode."
  echo
}

execute() {
  CMD=$1
  echo "[`date '+%Y-%m-%d %H:%M:%S %:z'`] Command: $CMD"
  [ "$why_run" = 1 ] || eval $CMD
}

ARGS="$@"
# Validation
while getopts 'yWh' OPT; do
  case $OPT in
    'y' )
      always_yes=1
      ;;
    'W' )
      why_run=1
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

if [ $# != 1 ]; then
  usage
  exit 1
else
  ROLE=$1
fi

case "$ROLE" in
  'master' | 'slave' | 'slave_public' )
    ;;
  # aliases
  'agent' | 'agent_public' )
    ROLE=${ROLE//agent/slave}
    ;;
  'public_agent' | 'public-agent' )
    ROLE='slave_public'
    ;;
  * )
    usage
    exit 1
    ;;
esac
echo "Node Role: $ROLE"

echo "This node will be set up as a $ROLE node."
while true; do
  [ "$always_yes" = 1 ] && break
  
  echo -n 'Continue the setup? [y/N]: '
  read answer
  case $answer in
    'y' | 'yes' )
      break
      ;;
    '' | 'n' | 'no' )
      echo 'Setup was aborted by user.'
      exit 0
      ;;
    * )
      ;;
  esac
done

# Setup
if [ -d /opt/mesosphere ]; then
  echo -e '[ERROR] DC/OS is already installed.'
  exit 1
fi

sudo='sudo'
[ `whoami` = 'root' ] && sudo=''

if [ ! -d /tmp/dcos ]; then
  execute 'mkdir /tmp/dcos'
fi
execute 'cd /tmp/dcos'

echo 'Downloading dcos_install.sh ...'
execute 'curl -O <%= node['dcos-grid']['bootstrap']['config']['bootstrap_url'] %>/dcos_install.sh'

echo "Installing DC/OS $ROLE node ..."
execute "$sudo bash dcos_install.sh $ROLE"

virt_sys='<%= node['virtualization']['system'] %>'
virt_role='<%= node['virtualization']['role'] %>'
if [ "$virt_role" = 'guest' -a \( "$virt_sys" = 'lxc' -o "$virt_sys" = 'lxd' \) ]; then
  echo "[WARN] This node is running in the Linux Container (${virt_sys})."
  execute "$sudo sed -i -e 's/^\(ExecStartPre=.*modprobe.*\)$/#\1/g' /etc/systemd/system/dcos-spartan.service"
  execute "$sudo systemctl daemon-reload; $sudo systemctl restart dcos-spartan"
fi
