#!/bin/bash

set -o pipefail

###########################################################
# This script copy local file(s) from a dir to Hadoop directory.
# Create hadoop direcotry if not exists.
# Gzip local file and move it to local archive directory.
###########################################################

usage() {
cat <<EOF
  MoveFileToHadoop.sh Usage:
    # Move files from Local to Hadoop dir
    # Pass 3 parameters.
    # Ex: MoveFileToHadoop.sh -s cfg_file -l local_file -h hadoop_dir
    # If hadoop_dir not exist then it will be created
EOF
}

while getopts "c:l:h:" OPTION
do
    case $OPTION in
        c) CONFIG=$OPTARG;;
        l) LOCAL=$OPTARG;;
        h) HADOOP_DIR=$OPTARG;;
    esac
done

# Check config file
if [ ! -f "$CONFIG" ]; then
  echo "Error...NO SUCH config file "$CONFIG
  usage
  exit 1
else
  #export property config
  source ${CONFIG}
fi

# Check any wildcard character used (Ex. *,?)in the local path and returns more than one file
FILE_LIST=`echo $@ | tr -s ' ' | grep -o ' -l .*' | sed -e 's/ -l //' | awk -F" -h " '{print $1}'`
OIFS=$IFS
IFS=" "
FILE_ARRAY=($FILE_LIST)
ARRAY_LEN=${#FILE_ARRAY[@]}
IFS=$OIFS
if [[ $ARRAY_LEN -gt 1 ]]
then
  echo "Error...No wildcard characters allowed"
  echo "INFO: Check your input on -l parameter"
  exit 1
fi

SOURCE=`readlink -f $LOCAL`
FILENAME=`basename $SOURCE`
# Check source is a directory or file
DIR_IND=0

if [[ ! -d "$SOURCE" ]]
then
  # Check source file exists
  if [ ! -f "$SOURCE" ]; then
    echo "NO SUCH file "$SOURCE
    usage
    exit 1
  else
    SOURCE_FILE_SIZE=`ls -l $SOURCE | tr -s ' ' | cut -d' ' -f5`
    SOURCE_DIR=$(dirname $SOURCE)
    DIR_IND=0
  fi
else
  # Check source has subdirectory
  SUB_DIR_EXISTS=`ls -l $SOURCE | grep ^d | wc -l`
  if [[ $SUB_DIR_EXISTS -ne 0 ]]
  then
    echo "Error...Local path has subdirectory, please check"
    echo "INFO: Local Path: $SOURCE"
    exit 1
  fi
  # Check staging dir is empty
  CNT=`ls -A $SOURCE | wc -l`
  if [[ $CNT -eq 0 ]]
  then
    echo "Error..Local path has no file(s),please check "$SOURCE
    exit 1
  fi
  SOURCE_DIR=$SOURCE
  DIR_IND=1
  SOURCE=${SOURCE}/*
fi

# Check Hadoop Directory Format
LAST_CHAR=`echo -n $HADOOP_DIR | tail -c -1`
if [[ $LAST_CHAR = '/' ]]
then
  HADOOP_DIR=`echo "$HADOOP_DIR" | sed -e 's/.$//'`
fi

# Check if active base directory exists
hadoop fs -test -d $HADOOP_DIR
DIR_EXISTS=$?
if [[ $DIR_EXISTS -ne 0 ]]
then
  echo "Error...Hadoop target directory DOES NOT exists"
  echo "INFO....Please create one as $HADOOP_DIR"
  exit 1
fi

# Parameters/Variables
SCRIPT_PATH=$0
SCRIPT_NAME=`basename $0`
APPEND_DIR="${TODAY_DT}"
HADOOP_DIR=${HADOOP_DIR}/${APPEND_DIR}

# Defalut log folder
LOGDIR=$MAP_LOG_DIR
LOGFILE="$LOGDIR/${SCRIPT_NAME}_${FILENAME}_$TIMESTAMP.log"

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
echo "Script Name  : $SCRIPT_PATH"  >> $LOGFILE 2>&1
echo "Linux Server : $SERVER"  >> $LOGFILE 2>&1
echo "----------------------------------------------------------------"  >> $LOGFILE 2>&1
echo "Local file : $SOURCE" >> $LOGFILE 2>&1
echo "Hadoop Dir : $HADOOP_DIR" >> $LOGFILE 2>&1
echo "" >> $LOGFILE 2>&1

# Check hadoop directory exists. Create one if not exists
hadoop fs -test -d $HADOOP_DIR
DIR_EXISTS=$?
if [[ $DIR_EXISTS -ne 0 ]]
then
  hadoop fs -mkdir $HADOOP_DIR
    if [[ $? -ne 0 ]]
    then
      echo "Error while creating hadoop directory "$HADOOP_DIR
      echo "Error while creating hadoop directory "$HADOOP_DIR >> $LOGFILE 2>&1
      exit 1
    else
      echo "Hadoor directory does not exists... created "$HADOOP_DIR
      echo "Hadoor directory does not exists... created "$HADOOP_DIR >> $LOGFILE 2>&1
    fi
fi

# Copy files to Hadoop folder
hadoop fs -copyFromLocal $SOURCE $HADOOP_DIR
RC=$?
if [[ $RC -ne 0 ]]
then
  echo "Error while copy local file($SOURCE) to Hadoop directory $HADOOP_DIR"
  echo "Error while copy local file($SOURCE) to Hadoop directory $HADOOP_DIR" >> $LOGFILE 2>&1
  exit 1
else
  if [[ $DIR_IND -eq 0 ]]
  then
    TARGET_FILE_SIZE=`hadoop fs -du -s $HADOOP_DIR/$FILENAME | cut -d' ' -f1`
    echo "Source file size "$SOURCE_FILE_SIZE >> $LOGFILE 2>&1
    echo "Target file size "$TARGET_FILE_SIZE >> $LOGFILE 2>&1
    if [[ $TARGET_FILE_SIZE -ne $SOURCE_FILE_SIZE ]]
    then
      echo "Error...Only partial file has been copied, please check"
      echo "Error...Only partial file has been copied, please check" >> $LOGFILE 2>&1
      exit 1
    else
      echo "File has been copied to hadoop successfully"
      echo "File has been copied to hadoop successfully" >> $LOGFILE 2>&1
    fi
  else

      echo "Local directory file(s) has been copied successfully"
    echo "Local directory file(s) has been copied successfully" >> $LOGFILE 2>&1
  fi
fi

# Archive source files into archive directory
BASE_ARC_DIR=$MAP_ARCHIVE_DIR
SOURCE=`readlink -f $LOCAL`
if [[ $DIR_IND -eq 0 ]]
then
  BASE_DIR=`dirname $SOURCE`
  TABLE_NAME=`basename $BASE_DIR`
  SUB_AREA_DIR=`dirname $BASE_DIR`
  SUB_AREA=`basename $SUB_AREA_DIR`
else
  SUB_AREA_DIR=`dirname $SOURCE`
  SUB_AREA=`basename $SUB_AREA_DIR`
  TABLE_NAME=`basename $SOURCE`
fi
ARC_DIR=$BASE_ARC_DIR/$SUB_AREA/$TABLE_NAME
echo "Moving file(s) from staging to archive..."
echo "Moving file(s) from staging to archive..." >> $LOGFILE 2>&1
echo "bash $UTILS_DIR/ArchiveFiles.sh -s $SOURCE -t $ARC_DIR"
echo "bash $UTILS_DIR/ArchiveFiles.sh -s $SOURCE -t $ARC_DIR" >> $LOGFILE 2>&1
bash $UTILS_DIR/ArchiveFiles.sh -s $SOURCE -t $ARC_DIR
if [[ $? -ne 0 ]]
then
  echo "Error...while moving files from staging to archive"
  echo "Error...while moving files from staging to archive" >> $LOGFILE 2>&1
  exit 1
else
  echo "File(s) has been successfully archived"
  echo "File(s) has been successfully archived" >> $LOGFILE 2>&1
fi

# Remove archive files based on config retention value
echo "Removing archive files based on config retention value..."
echo "Removing archive files based on config retention value..." >> $LOGFILE 2>&1
echo "Call... bash $UTILS_DIR/RemoveStagingArchiveDir.sh -c $CONFIG -s $ARC_DIR" >> $LOGFILE 2>&1
bash $UTILS_DIR/RemoveStagingArchiveDir.sh -c $CONFIG -s $ARC_DIR >> $LOGFILE 2>&1
if [[ $? -ne 0 ]]
then
  echo "ERROR...occured while removing archive files from $ARC_DIR, please check..."
  echo "ERROR...occured while removing archive files from $ARC_DIR, please check..." >> $LOGFILE 2>&1
  exit 1
else
  echo "Archive files have been removed"
  echo "Archive files have been removed" >> $LOGFILE 2>&1
fi

# Find and remove the log files older than 15 days
if [[ ! -z $LOGDIR ]]
then
  find $LOGDIR -name '*.log' -mtime +15 -exec rm {} \;
fi

echo "INFO: $SCRIPT_NAME has been completed successfully"
echo "INFO: $SCRIPT_NAME has been completed successfully" >> $LOGFILE 2>&1
echo "----------------------------------------------------------------" >> $LOGFILE 2>&1
echo "$SCRIPT_NAME End Time (CST) : $END_TIME" >> $LOGFILE 2>&1
echo "----------------------------------------------------------------"  >> $LOGFILE 2>&1

exit 0
