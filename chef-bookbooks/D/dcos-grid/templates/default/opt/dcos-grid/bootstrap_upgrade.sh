#!/usr/bin/env bash

# https://dcos.io/docs/1.8/administration/upgrading/
# https://dcos.io/docs/1.7/administration/upgrading/

PATH=.:/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin:`dirname $0`

install_dir=<%= File.dirname(node['dcos-grid']['bootstrap']['genconf_dir']) %>
release_script_name=<%= node['dcos-grid']['dcos_release_script_name'] %>
rel_checksum='<%= node['dcos-grid']['dcos_release_checksum'] %>'
port=<%= node['dcos-grid']['bootstrap']['port'] %>

usage() {
  echo 'Usage: bootstrap_upgrade.sh [-c] [-E] [-y] [-W] [-h]'
  echo 'This script upgrades DC/OS bootstrap node.'
  echo
  echo "Options:"
  echo "  -c: commit upgrade."
  echo "  -E: don't update DC/OS release ($release_script_name)."
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
while getopts 'cEyWh' OPT; do
  case $OPT in
    'c' )
      commit_flag=1
      ;;
    'E' )
      preserve_same_version=1
      ;;
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

sudo='sudo'
[ `whoami` = 'root' ] && sudo=''

confirm() {
  while true; do
    [ "$always_yes" = 1 ] && break

    echo -n 'Continue the process? [y/N]: '
    read answer
    case $answer in
      'y' | 'yes' )
        break
        ;;
      '' | 'n' | 'no' )
        echo 'Process was aborted by user.'
        exit 0
        ;;
      * )
        ;;
    esac
  done
}

restart_nginx() {
  echo 'Restart the nginx (Docker container) ...'
  container_id=`$sudo docker ps | grep "${port}->80/tcp" | awk '{print $1}'`
  if [ "$container_id" != '' ]; then
    echo "Docker container (ID: $container_id) for the bootstrap service is already running."
    echo 'Stop the container ...'
    execute "$sudo docker stop $container_id"
  fi

  echo 'Launching Docker container for the bootstrap service ...'
  execute "cd $install_dir" 
  execute "$sudo docker run -d --restart always -p ${port}:80 -v ${install_dir}/genconf/serve:/usr/share/nginx/html:ro nginx"
}

upgrade() {
  execute "cd $install_dir"

  echo 'Back up the current installation script ...'
  execute "$sudo mv ./genconf/serve{,-`date '+%Y%m%d_%H%M%S'`}"

  if [ "$preserve_same_version" = 1 ]; then
    dcos_release_script="${install_dir}/${release_script_name}"
    if [ -e "$dcos_release_script" ]; then
      echo "Preserve same DC/OS release ($dcos_release_script)."
    else
      echo "[ERROR] Existing DC/OS release ($dcos_release_script) is not found on the local filesystem."
      exit 1
    fi
  else
    echo 'Downloading new DC/OS release ...'
    execute "$sudo curl -O <%= node['dcos-grid']['dcos_release_url'] %>"
    if [ "$rel_checksum" != '' ]; then
      if [ "$(sha256sum $release_script_name | awk '{print $1}')" != $rel_checksum ]; then
        echo '[ERROR] dcos binary file checksum mismatch.'
        execute "$sudo rm $release_script_name"
        exit 1
      fi
    fi
  fi

  echo 'Generating new DC/OS configurations ...'
  execute "$sudo bash $release_script_name"

  echo 'Back up the generated dcos_install.sh script ...'
  execute "$sudo cp -a ./genconf/serve/dcos_install.sh{,.pkg-dist}"

  echo 'Disable Docker restarts in dcos_install.sh'
  execute "$sudo sed -i -e 's/systemctl restart systemd-journald//g' -e 's/systemctl restart docker//g' genconf/serve/dcos_install.sh"

  restart_nginx

  cat << EOM
Please execute the following command in preparation to get new node in on the cluster
after the cluster upgrade finished.
  $ ${install_dir}/bootstrap_upgrade.sh -c
EOM
}

commit() {
  echo 'Commit the upgrade ...'
  execute "cd $install_dir"
  if [ -e ./genconf/serve/dcos_install.sh -a -e ./genconf/serve/dcos_install.sh.pkg-dist ]; then
    execute "$sudo mv ./genconf/serve/dcos_install{,4upgrade}.sh"
    execute "$sudo mv ./genconf/serve/dcos_install.sh{.pkg-dist,}"

    restart_nginx
  else
    echo '[ERROR] ./genconf/serve/dcos_install.sh or ./genconf/serve/dcos_install.sh.pkg-dist does not exist.'
    exit 1
  fi
}

# Main
if [ "$commit_flag" = 1 ]; then
  echo 'This upgrade will be commited.'
  confirm
  commit
else
  echo 'This node will be upgraded as a Bootstrap node.'
  confirm
  upgrade
fi
