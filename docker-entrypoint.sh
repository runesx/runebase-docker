#!/bin/bash
set -e
GOSU="gosu runebase"
# don't use gosu when id is not 0
if [ "$(id -u)" -ne "0" ];then
  GOSU=""
fi

if [[ "$1" == "runebase-cli" || "$1" == "runebase-tx" ]]; then
	exec $GOSU "$@"
else
  exec $GOSU "runebased -daemon"
fi

