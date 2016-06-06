#!/bin/bash
set -x
set -v

function do_help {
  echo HELP:
  echo "Supported commands:"
  echo "   master              - Start a Kudu Master"
  echo "   tserver             - Start a Kudu TServer"
  echo "   cli                 - Start a Kudu CLI"
  echo "   help                - print useful information and exit"
  echo ""
  echo "Other commands can be specified to run shell commands."
  echo "Set the environment variable KUDU_OPTS to pass additional"
  echo "arguments to the kudu process. DEFAULT_KUDU_OPTS contains"
  echo "a recommended base set of options."

  exit 0
}

mkdir -p /var/lib/kudu/
DEFAULT_KUDU_OPTS="-logtostderr \
 -fs_wal_dir=/var/lib/kudu/ \
 -use_hybrid_clock=false"

KUDU_OPTS=${KUDU_OPTS:-${DEFAULT_KUDU_OPTS}}

cd /kudu/build/release
if [ "$1" = 'master' ]; then
	exec bin/kudu-master ${KUDU_OPTS}
elif [ "$1" = 'tserver' ]; then
  exec bin/kudu-tserver -tserver_master_addrs ${KUDU_MASTER} ${KUDU_OPTS}
elif [ "$1" = 'cli' ]; then
  shift; # Remove first arg and pass remainder to kudu cli
  exec bin/kudu-ts-cli -server_address=${KUDU_TSERVER} "$@"
elif [ "$1" = 'help' ]; then
  do_help
fi

exec "$@"
