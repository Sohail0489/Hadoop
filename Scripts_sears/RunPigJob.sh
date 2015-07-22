#!/bin/bash

set -o pipefail

##################################################################################
# This script executes a pig script
# 1. It requires 3 parameters and optional control file parameter
# 2. It looks for STORE statement in the pig script and remove them before run
##################################################################################

usage() {
cat <<EOF
$0 wrapper Usage:
   -c - MAP Config file                (required)
   -p - Pig Script file                (required)
   -r - Pig property config file       (required)
   -l - Pig Control file               (optional)
EOF
}

while getopts "c:p:r:l:" OPTION
do
    case $OPTION in
        c) CONFIG=$OPTARG;;
        p) PIG_SCRIPT=$OPTARG;;
        r) PIG_CONFIG=$OPTARG;;
        l) PIG_CTRL_FILE=$OPTARG;;
    esac
done

if [[ -z ${CONFIG} ]] || [[ -z ${PIG_CONFIG} ]] || [[ -z ${PIG_SCRIPT} ]]
then
  usage
  exit 1
fi

# Check MAP config file
if [ ! -f "$CONFIG" ]; then
  echo "Error...NO SUCH MAP config file "$CONFIG
  usage
  exit 1
else
  # Export config file
  source ${CONFIG}
fi

# Check Pig properties config file
if [ ! -f "$PIG_CONFIG" ]; then
  echo "Error...NO SUCH Pig config file "$PIG_CONFIG
  usage
  exit 1
fi

# Check Pig script file
if [ ! -f "$PIG_SCRIPT" ]; then
  echo "Error...NO SUCH Pig script file "$PIG_SCRIPT
  usage
  exit 1
fi

# Check for Pig control file
if [[ ! -z "$PIG_CTRL_FILE" ]] && [[ ! -f "$PIG_CTRL_FILE" ]]
then
  echo "Error...NO SUCH Pig control file "$PIG_CTRL_FILE
  exit 1
else
  if [[ ! -z "$PIG_CTRL_FILE" ]]
  then
    PIG_CTRL_FILE_IF_EXISTS="-m $PIG_CTRL_FILE"
  fi
fi

# Variables
REG_WORK='(\/work\/)+'

# Remove existing Pig STORE Dir
OIFS=$IFS
IFS=$'\n'
STORE_INTO=( $(grep -i 'STORE ' $PIG_SCRIPT | tr -s ' ' | grep -i ' into ' | sed -e "s/'/\"/g" | sed -e "s/[\(\)]/ /g") )
if [[ ${#STORE_INTO[@]} -gt 0 ]]
then
  i=0
  for item in ${STORE_INTO[@]}
  do
    OUTPUT_DIR=`eval "echo \"$item\"" | sed "s/ /\n/g" | grep ^/`
    if [[ ${#OUTPUT_DIR} -gt 0 ]]
    then
      STORE_OUTPUT_DIR[$i]="$OUTPUT_DIR"
      i=$i+1
    fi
  done
  # Remove Hadoop existing output directory
  if [[ ${#STORE_OUTPUT_DIR[@]} -gt 0 ]]
  then
    for item in ${STORE_OUTPUT_DIR[@]}
    do
      hadoop fs -test -d $item
      DIR_EXISTS=$?
      if [[ $DIR_EXISTS -eq 0 ]]
      then
         # Check target directory is a work directory
         if ! [[ $item =~ $REG_WORK ]]
         then
           echo "Error...NOT a Hadoop work directory, please check"
           echo "INFO: $item"
           exit 1
         fi
         hadoop fs -rm -r -skipTrash $item
         if [[ $? -ne 0 ]]
         then
           echo "Error...while removing directory "$item
           exit 1
         fi
      fi
    done
  else
    echo "Error...not a valid pig STORE statement, please check "$PIG_SCRIPT
    exit 1
  fi
else
  echo "Error...The pig script does not have any STORE statement "$PIG_SCRIPT
  exit 1
fi

IFS=$OIFS

# Log file
PIG_SCRIPT=`readlink -f $PIG_SCRIPT`
LOGDIR=$MADE_LOG_DIR
FILENAME=`basename "${PIG_SCRIPT}"`
SCRIPT_NAME=`basename "${PIG_SCRIPT}"`
LOGFILE="$LOGDIR/${FILENAME}_$TIMESTAMP.log"

# Log header info
echo "----------------------------------------------------------------"
echo "$SCRIPT_NAME begins..."
echo "----------------------------------------------------------------"
echo "Script is being run by LINUX user : $USER"
echo "------------------------------------------------"
echo "$SCRIPT_NAME Start Time (CST) : $START_TIME"
echo "----------------------------------------------------------------" > $LOGFILE 2>&1
echo "$SCRIPT_NAME Start Time (CST) : $START_TIME" >> $LOGFILE 2>&1
echo "----------------------------------------------------------------"  >> $LOGFILE 2>&1
echo "Processing..."
echo "Linux user   : $USER"  >> $LOGFILE 2>&1
echo "Script Name  : $PIG_SCRIPT"  >> $LOGFILE 2>&1
echo "Linux Server : $SERVER"  >> $LOGFILE 2>&1
echo "----------------------------------------------------------------"  >> $LOGFILE 2>&1
echo "General Config file : $CONFIG" >> $LOGFILE 2>&1
echo "Pig Config file     : $PIG_CONFIG" >> $LOGFILE 2>&1
echo "Pig Control file    : $PIG_CTRL_FILE_IF_EXISTS" >> $LOGFILE 2>&1
echo "" >> $LOGFILE 2>&1

# Run the pig script
echo "Runing....pig -Dmapred.map.tasks.speculative.execution="true" -Dmapred.reduce.tasks.speculative.execution="true" -file $PIG_SCRIPT -m $PIG_CONFIG $PIG_CTRL_FILE_IF_EXISTS"
echo "Runing....pig -Dmapred.map.tasks.speculative.execution="true" -Dmapred.reduce.tasks.speculative.execution="true" -file $PIG_SCRIPT -m $PIG_CONFIG $PIG_CTRL_FILE_IF_EXISTS" >> $LOGFILE 2>&1

pig -Dmapred.map.tasks.speculative.execution="true" -Dmapred.reduce.tasks.speculative.execution="true" \
    -file $PIG_SCRIPT -m $PIG_CONFIG $PIG_CTRL_FILE_IF_EXISTS >> $LOGFILE 2>&1
RC=$?
if [[ $RC -ne 0 ]]
then
  echo "Error...while running the pig script "$PIG_SCRIPT
  echo "Error...while running the pig script "$PIG_SCRIPT >> $LOGFILE 2>&1
  exit 1
else
  echo "Pig script has been completed successfully"
  echo "Pig script has been completed successfully" >> $LOGFILE 2>&1
fi

# Find and remove the log files older than 15 days
if [[ ! -z $LOGDIR ]]
then
  find $LOGDIR -name '*.log' -mtime +15 -exec rm {} \;
fi

exit 0
