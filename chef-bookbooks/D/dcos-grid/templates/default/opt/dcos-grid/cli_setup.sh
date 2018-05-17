#!/usr/bin/env bash

PATH=.:/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin:`dirname $0`

install_path='<%= node['dcos-grid']['cli']['install_path'] %>'
cli_checksum='<%= node['dcos-grid']['cli']['release_checksum'] %>'
oauth_enabled='<%= node['dcos-grid']['bootstrap']['config']['oauth_enabled'] %>'
a_master='<%= node['dcos-grid']['bootstrap']['config']['master_list'][0] %>'

usage() {
  echo 'Usage: cli_setup.sh [-y] [-h]'
  echo 'This script sets up DC/OS client.'
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

echo 'DC/OS client will be installed.'
while true; do
  [ "$always_yes" = 1 ] && break

  echo -n 'Continue the install? [y/N]: '
  read answer
  case $answer in
    'y' | 'yes' )
      break
      ;;
    '' | 'n' | 'no' )
      echo 'Install was aborted by user.'
      exit 0
      ;;
    * )
      ;;
  esac
done

sudo='sudo'
[ `whoami` = 'root' ] && sudo=''

execute "$sudo curl <%= node['dcos-grid']['cli']['release_url'] %> -o $install_path"
if [ "$cli_checksum" != '' ]; then
  if [ "$(sha256sum $install_path | awk '{print $1}')" != $cli_checksum ]; then
    echo '[ERROR] dcos binary file checksum mismatch.'
    execute "$sudo rm $install_path"
    exit 1
  fi
fi
execute "$sudo chmod +x $install_path"
scheme='http'
[ "$oauth_enabled" = 'true' ] && scheme='https'
[ "$a_master" != '' ] && execute "$sudo $install_path config set core.dcos_url ${scheme}://${a_master}"

# old way
#mkdir -p dcos && cd dcos && 
#curl -O https://downloads.dcos.io/dcos-cli/install.sh && 
#bash ./install.sh . https://<%= node['dcos-grid']['bootstrap']['config']['master_list'][0] %> && 
#source ./bin/env-setup
