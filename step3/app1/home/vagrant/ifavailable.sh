#! /bin/bash
server=gateway.training.com
ping -c1 -W1 -q $server &>/dev/null
status=$( echo $? )
if [[ $status == 0 ]] ; then
  echo "$server is available"
else
  echo "$server is not respond. Exit status: $status"
fi
