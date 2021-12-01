{{- define "hbasecluster.hmasterscript" }}
#! /bin/bash
set -m
export HBASE_LOG_DIR=$0
export HBASE_CONF_DIR=$1
export HBASE_HOME=$2
export USER=$(whoami)

mkdir -p $HBASE_LOG_DIR
ln -sf /dev/stdout $HBASE_LOG_DIR/hbase-$USER-master-$(hostname).out
ln -sf /dev/stdout $HBASE_LOG_DIR/hbase-$USER-master-$(hostname).log

function shutdown() {
  echo "Stopping Hmaster"
  $HBASE_HOME/bin/hbase-daemon.sh stop master
}

trap shutdown SIGTERM
exec $HBASE_HOME/bin/hbase-daemon.sh foreground_start master &
wait
{{- end }}
