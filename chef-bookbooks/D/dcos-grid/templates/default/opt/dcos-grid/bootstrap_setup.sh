#!/usr/bin/env bash

# https://dcos.io/docs/1.8/administration/installing/custom/advanced/
# https://dcos.io/docs/1.7/administration/installing/custom/advanced/

PATH=.:/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin:`dirname $0`

install_dir=<%= File.dirname(node['dcos-grid']['bootstrap']['genconf_dir']) %>
release_script_name=<%= node['dcos-grid']['dcos_release_script_name'] %>
rel_checksum='<%= node['dcos-grid']['dcos_release_checksum'] %>'
port=<%= node['dcos-grid']['bootstrap']['port'] %>

usage() {
  echo 'Usage: bootstrap_setup.sh [-d|-E|-s] [-y] [-W] [-h]'
  echo 'This script sets up the DC/OS bootstrap node and launches the Nginx.'
  echo
  echo "Options:"
  echo "  -d: download DC/OS release ($release_script_name) only."
  echo "  -E: don't download DC/OS release ($release_script_name) if it already exits."
  echo "  -s: (re)start the Nginx (Docker container) only."
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
while getopts 'dEsyWh' OPT; do
  case $OPT in
    'd' )
      download_flag=1
      ;;
    'E' )
      preserve_existing_version=1
      ;;
    's' )
      start_flag=1
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

confirm() {
  echo 'This node will be set up as a Bootstrap node.'
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
}

restart_nginx() {
  echo '(Re)start the nginx (Docker container) ...'
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

download_dcos() {
  echo 'Downloading DC/OS release ...'
  execute "cd $install_dir" 
  execute "$sudo curl -O <%= node['dcos-grid']['dcos_release_url'] %>"
  if [ "$rel_checksum" != '' ]; then
    if [ "$(sha256sum $release_script_name | awk '{print $1}')" != $rel_checksum ]; then
      echo '[ERROR] dcos binary file checksum mismatch.'
      execute "$sudo rm $release_script_name"
      exit 1
    fi
  fi
}

sudo='sudo'
[ `whoami` = 'root' ] && sudo=''

if [ "$download_flag" = 1 ]; then
  download_dcos
elif [ "$start_flag" = 1 ]; then
  restart_nginx
else
  # Setup
  confirm
  execute "cd $install_dir"
  dcos_release_script="${install_dir}/${release_script_name}"
  if [ "$preserve_existing_version" = 1 -a -e "$dcos_release_script" ]; then
    echo "Preserve existing DC/OS release ($dcos_release_script)."
  else
    download_dcos
  fi

  echo 'Generating DC/OS configurations ...'
  execute "$sudo bash $release_script_name"

  restart_nginx
fi
