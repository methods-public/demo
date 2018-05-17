#!/bin/bash
# Grabs the smartctl information for a disk

eexit() {
  local error_str="$@"
  echo $error_str
  exit 1
}

[ $# -eq 2 ] || eexit "Invalid Arguments"

readonly path=$1
readonly option_flag=$2

readonly loadcap=15
readonly oldage=604800
readonly midage=86400

readonly sanitized_path=`echo $path | sed 's/\//_/g'`
readonly cache_dir=/tmp/disk_analyser
readonly ${cache_dir}/smartctl_${option_flag}_${sanitized_path}
readonly cmd="/usr/sbin/smartctl -${option_flag} ${path}"

readonly PROGNAME=$(basename "$0")
readonly LOCKFILE_DIR=/tmp
readonly LOCK_FD=200

lock() {
  local prefix="${1}_$sanitized_path"
  local fd=${3:-$LOCK_FD}
  local lock_file=$LOCKFILE_DIR/$prefix.lock

  # Create lock File
  eval "exec $fd>$lock_file"

  # acquier the lock
  flock -n $fd && return 0 || return 1
}

high_load() {
  load=$(awk '{print $1}' /proc/loadavg | cut -d '.' -f 1)
  [ "$load" -lt "$1" ] && return 0
  return 1
}
older_than() {
  file=$1
  agelimit=$2
  age=$(($(date +%s) - $(stat -L --format %Y $file)))
  return $(( age  > agelimit ))
}

update_cache_file() {
  lock $PROGNAME $DIRECTORY || return
  mkdir -p $cache_dir
  $($cmd > $cache_file)
}


main() {
  run
}

can_update() {
  # Yes if it doesn't exist
  [ ! -e $cache_file ] && return 0
  # Yes if it's ancient
  older_than $cache_file $old_age
  [ "$?" -eq 0 ] && return 0
  # Yes if it's quite old and the load is low
  older_than $cache_file $midage
  old=$?
  high_load $loadcap
  too_high=$?
  [ "$old" -eq 0 ] && ! [ "$too_high" -eq 0 ] && return 0
  # No if it's fresh
  return 1
}

run() {
  can_update
  [ "$?" -eq 0 ] && update_cache_file
  cat $cache_file
}

main
