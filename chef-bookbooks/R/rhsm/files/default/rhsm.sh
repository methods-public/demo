#!/bin/bash
#
# rhsm Startup script for RedHat Subscription Management
#
# chkconfig: 345 86 15
# decription: RedHat Subscription Management registration

start () {
  echo -n "No actions to execute"
}
stop () {
  echo -n "Unregistering from RedHat Subscription Management."
  subscription-manager unregister
}
# See how we were called.
case "$1" in
  start)
    start
    ;;  
  stop)
    stop
    ;;  
  *)
    echo $"Usage: $0 {start|stop}"
    exit 1
esac

exit $?
