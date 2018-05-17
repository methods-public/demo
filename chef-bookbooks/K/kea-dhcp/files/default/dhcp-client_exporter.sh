#!/bin/bash

echo "# TYPE node_ip_valid_lifetime_seconds gauge"

for interface in "$@"
do
  ip_valid_lifetime=$(ip a s $interface | grep -Po '(?<=valid_lft )(\d*)')
  echo "node_ip_valid_lifetime_seconds{network_interface=\""${interface}\""}"\
       "${ip_valid_lifetime}"
done
