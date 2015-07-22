#!/bin/bash

set -o pipefail

######################################################
# This script runs a jar file
# 1. Need a jar file and a source dir
# 2. Target dir should not be present in hadoop
######################################################

usage() {
cat <<EOF
  LoadToProd Usage:
        -j - Jar file
        -s - Source Hadoop Dir
        -t - Target Hadoop Dir
        -l - Control file
EOF
}

while getopts "j:s:t:l:" OPTION
do
    case $OPTION in
        j) JAR_FILE=$OPTARG;;
        s) SOURCE_DIR=$OPTARG;;
        t) TARGET_DIR=$OPTARG;;
        l) CTRL_FILE=$OPTARG;;
    esac
done

if [[ -z ${JAR_FILE} ]] || [[ -z ${SOURCE_DIR} ]] || [[ -z ${TARGET_DIR} ]]
then echo "Options -j -s -t can not be empty"
     usage
     exit 1
fi

if [ ! -f "$JAR_FILE" ]; then
  echo "Error...NO SUCH JAR file "$JAR_FILE
  exit 1
fi

# Check for control file
if [[ ! -z "$CTRL_FILE" ]]
then
  CTRL_FILE_IF_EXISTS="-files $CTRL_FILE"
fi

# Check source hadoop directory exists
hadoop fs -test -d $SOURCE_DIR
DIR_EXISTS=$?
if [[ $DIR_EXISTS -ne 0 ]]
then
  echo "Error...NO SUCH Source Hadoop directory "$SOURCE_DIR
  exit 1
fi

# Check source hadoop dir has data
DIR_EMPTY=`hadoop fs -count $SOURCE_DIR | tr -s ' ' | cut -d' ' -f3`
if [[ $DIR_EMPTY -eq 0 ]]
then
  echo "Error...Source dir is empty, please check..."
  echo "INFO: Source dir: $SOURCE_DIR"
  exit 1
fi

# Run a JAR file
echo ""
echo "Running...hadoop jar $JAR_FILE $CTRL_FILE_IF_EXISTS $SOURCE_DIR $TARGET_DIR"
echo ""
hadoop jar $JAR_FILE $CTRL_FILE_IF_EXISTS $SOURCE_DIR $TARGET_DIR
if [[ $? -ne 0 ]]
then
  echo "Error...while running JAR file, please check"
  exit 1
fi

exit 0

