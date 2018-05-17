#!/usr/bin/env bash

# https://dcos.io/docs/1.8/administration/installing/custom/advanced/
# https://dcos.io/docs/1.7/administration/installing/custom/advanced/

PATH=.:/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin:`dirname $0`

exhibitor_storage_backend=<%= node['dcos-grid']['bootstrap']['config']['exhibitor_storage_backend'] %>

usage() {
  echo 'Usage: node_upgrade.sh [-y] [-W] [-h] {master,agent,slave,agent_public,slave_public}'
  echo 'This script upgrades DC/OS master or agent node.'
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

echo "This node will be upgraded as a $ROLE node."
while true; do
  [ "$always_yes" = 1 ] && break

  echo -n 'Continue the upgrade? [y/N]: '
  read answer
  case $answer in
    'y' | 'yes' )
      break
      ;;
    '' | 'n' | 'no' )
      echo 'Upgrade was aborted by user.'
      exit 0
      ;;
    * )
      ;;
  esac
done

sudo='sudo'
[ `whoami` = 'root' ] && sudo=''

if [ $ROLE = 'master' ]; then
  toybox=/opt/mesosphere/bin/toybox
  if [ -e "$toybox" ]; then
    zk_mode=`echo stat | $toybox nc localhost 2181 | grep "Mode:"`
  else
    zk_mode='Mode: unknown'
  fi
  echo "Zookeeper $zk_mode"

  if echo $zk_mode | grep 'leader' > /dev/null 2>&1; then
    echo 'This node is Zookeeper leader. You should upgrade Zookeeper leader node at the end.'
    while true; do
      [ "$always_yes" = 1 ] && break

      echo -n 'Continue the upgrade? [y/N]: '
      read answer
      case $answer in
        'y' | 'yes' )
          break
          ;;
        '' | 'n' | 'no' )
          echo 'Upgrade was aborted by user.'
          exit 0
          ;;
        * )
          ;;
      esac
    done
  fi
fi

# Upgrade
if [ ! -d /tmp/dcos ]; then
  execute 'mkdir /tmp/dcos'
fi
execute 'cd /tmp/dcos'

echo 'Downloading new dcos_install.sh ...'
execute "$sudo curl -O <%= node['dcos-grid']['bootstrap']['config']['bootstrap_url'] %>/dcos_install.sh"

pkgpanda=/opt/mesosphere/bin/pkgpanda
if [ -e "$pkgpanda" ]; then
  echo 'Uninstalling pkgpanda ...'
  execute "$sudo -i $pkgpanda uninstall"
fi

if [ -e /opt/mesosphere ]; then
  echo 'Removing data directory ...'
  execute "$sudo rm -rf /opt/mesosphere /etc/mesosphere"
fi

case "$ROLE" in
  'master' )
    if [ $exhibitor_storage_backend != 'static' ]; then
      execute "$sudo useradd --system --home-dir /opt/mesosphere --shell /sbin/nologin -c 'DCOS System User' dcos_exhibitor; $sudo chown -R dcos_exhibitor /var/lib/zookeeper"
    fi
    ;;
  'slave' | 'slave_public' )
<< "#__CO__"
    # ???: If you have not made explicit disk size reservations, you must create
    #  a placeholder for the disk reservation file. This prevents the installer
    #  from building a new disk reservation file that might conflict with your
    #  stored agent metadata:
    #    $ sudo mkdir -p /var/lib/dcos
    #    $ sudo touch /var/lib/dcos/mesos-resources
    execute "$sudo mkdir -p /var/lib/dcos; $sudo touch /var/lib/dcos/mesos-resources"
#__CO__
    ;;
  * )
    ;;
esac

echo 'Waiting for releasing of service ports ...'
[ "$why_run" = 1 ] || sleep 60s
retry=5
for i in `seq 1 $retry`; do
  [ "$why_run" = 1 ] && break

  if $sudo bash dcos_install.sh --preflight-only $ROLE > /dev/null 2>&1; then
    echo 'done.'
    break
  elif [ $i = $retry ]; then
    echo '[ERROR] release time out.'
    exit 1
  else
    echo -n '.......... '
    sleep 10s
  fi
done

echo "Installing DC/OS $ROLE node ..."
execute "$sudo bash dcos_install.sh $ROLE"

virt_sys='<%= node['virtualization']['system'] %>'
virt_role='<%= node['virtualization']['role'] %>'
if [ "$virt_role" = 'guest' -a \( "$virt_sys" = 'lxc' -o "$virt_sys" = 'lxd' \) ]; then
  echo "[WARN] This node is running in the Linux Container (${virt_sys})."
  execute "$sudo sed -i -e 's/^\(ExecStartPre=.*modprobe.*\)$/#\1/g' /etc/systemd/system/dcos-spartan.service"
  execute "$sudo systemctl daemon-reload; $sudo systemctl restart dcos-spartan"
fi

case "$ROLE" in
  'master' )
    cat << EOM
Please validate the upgrade
  - Monitor the Exhibitor UI to confirm that the Master rejoins the ZooKeeper
    quorum successfully (the status indicator will turn green). The Exhibitor
    UI is available at http://<dcos_master>:8181/.
  - Verify that curl http://<dcos_master_private_ip>:5050/metrics/snapshot has
    the metric registrar/log/recovered with a value of 1.
  - Verify that http://<dcos_master>/mesos indicates that the upgraded master
    is running Mesos upgraded version.
EOM
    ;;
  'slave' | 'slave_public' )
    cat << EOM
Please validate the upgrade
  - Verify that curl http://<dcos_agent_private_ip>:5051/metrics/snapshot has
    the metric slave/registered with a value of 1.
  - Monitor the Mesos UI to verify that the upgraded node rejoins the DC/OS
    cluster and that tasks are reconciled (http://<dcos_master>/mesos).
EOM
    ;;
  * )
    ;;
esac
