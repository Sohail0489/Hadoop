#!/bin/bash


[ -f /etc/profile.d/hadoop.sh ] && . /etc/profile.d/hadoop.sh
SCRIPT_DIR=$(dirname $0)
cd $SCRIPT_DIR

. ../config/map.props

TODAY=$(date +%Y%m%d)
PGM_NAME=$(basename $0)
MR_NAME="Load Test Data $1"
LOG_FILE=$LOG_DIR/$PGM_NAME.$TODAY

STREAMING_HOME=/opt/cloudera/parcels/CDH-5.1.2-1.cdh5.1.2.p0.3/lib/hadoop-mapreduce
RUBY=/usr/local/ruby19/bin/ruby
PROJ=
INPUT=$INCOMING_DIR/$1
OUTPUT=$SMITH_DIR/$1
echo $1

TIMEOUT=3600000 # number of milliseconds - 60 minutes (default 10 minutes)
MAPPER=$SCRIPT_DIR/strip_space.rb
MAPPER1=strip_space.rb
REDUCER=$SCRIPT_DIR/generic_output_reducer.rb
REDUCER1=generic_output_reducer.rb
NO_OF_REDUCERS=$2

NUMERIC_PARTITIONER_JAR=/appl/common/jars/SHCHadoopExtnJAR.jar
NUMERIC_PARTITIONER=com.shc.hadoop.mapred.partitioners.NumericPartitioner
BINARY_OUTPUT_FORMAT=com.shc.hadoop.mapred.formats.TxtOutputFormat

log ()
{
  if [[ ! -d $LOG_DIR ]]; then
    mkdir -p $LOG_DIR
  fi
  msg=$1
  echo `date +"%m/%d/%Y:%T: $msg"` | tee -a $LOG_FILE

}

cleanup_logs ()
{
  log "INFO:  Removing old log files"
  find $LOG_DIR -name "$PGM_NAME.*" -mtime +7 -exec rm {} \; | tee -a $LOG_FILE
  log "INFO:  Old log files removed"

}

check_input_file ()
{
  log "INFO:  Checking for $INPUT"
  /usr/bin/hadoop fs -test -e $INPUT

  if [[ $? == 0 ]]; then
    log "INFO:  $INPUT exists"
  else
    log "ERROR: $INPUT not found"
    exit 1
  fi

}

remove_gold ()
{
  log "INFO:  Checking for existing $OUTPUT"
  /usr/bin/hadoop fs -test -e $OUTPUT

  if [[ $? == 0 ]]; then
    log "INFO:  GOLD directory $OUTPUT exists"
    log "INFO:  Removing $OUTPUT"
    /usr/bin/hadoop fs -rm -R $OUTPUT
    if [[ $? != 0 ]]; then
      log "ERROR:  Unable to remove $OUTPUT"
      exit 1
    fi
  else
    log "INFO:  Gold file $OUTPUT not found"
  fi

}

#############################################################################
# MAIN
#############################################################################
log "INFO:  Starting $PGM_NAME"

if [[ $# -lt 2 ]]; then
  log "ERROR: Incorrect number of arguments"
  log "Usage:  $0 <tablename> <number of reducers>"
  exit 1
fi

cleanup_logs
#remove_work
check_input_file
remove_gold


yarn jar  $STREAMING_HOME/hadoop-streaming.jar \
  -D mapreduce.job.name="$MR_NAME" \
  -D mapreduce.job.reduces=$NO_OF_REDUCERS \
  -libjars $NUMERIC_PARTITIONER_JAR \
  -partitioner $NUMERIC_PARTITIONER \
  -outputformat $BINARY_OUTPUT_FORMAT \
  -input $INPUT \
  -output $OUTPUT \
  -mapper "$RUBY ${MAPPER1}"  \
  -file $MAPPER \
  -reducer "$RUBY ${REDUCER1}" \
  -file $REDUCER
  

if [[ $? != 0 ]]; then
  log "ERROR:  Load to $OUTPUT failed."
  exit 1
fi
log "INFO:  Completed $PGM_NAME"
