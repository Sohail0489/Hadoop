#!/bin/bash

######################################################################################################
#	TDextractor.sh
#	Usage: TDextractor.sh -q Query script -i HDFS_Incoming [-d <Date YYYYMMDD> -t ] [ -u -p ]
#
#  Date                       User
#------------------------------------------------------------------------------------------------
# 11/10/14                    jmario1                 Changes to remove hardcode path and all
#                                                     property file as an option
######################################################################################################

SCRIPTS_DIR=$(dirname $(readlink -f $0))

# Overriding the location of these files
#. /appl/common/scripts/log-funcs
#. /appl/common/scripts/hadoop-funcs
. $SCRIPTS_DIR/log-funcs
. $SCRIPTS_DIR/hadoop-funcs

. /appl/conf/$USER/global.properties

usage() {
  cat <<EOF
  usage : $0  -q SQL script -i Incoming HDFS Directory [-d Date YYYYMMDD | -t ] [ -u TDUser -p TDPassword ] [ -s Teradata host]
  Script to Run Teradata Extracts
  OPTIONS:
	Mandatory
        -q      Query Script(SQL) with full Path
        -i      Incoming HDFS Directory
	Optional
        -c      Configuration file with full Path
        -d      Date of the Extract, defaults to TODAY
        -t      Timestamp of the Extract, if supplied overrides the Day/Date
        -s      Teradata Server (host) name
	-u      Teradata Username
        -p      Teradata Password
        -h      Show this message
EOF
}

while getopts "tq:i:d::u:p:h:s:c:" OPTION
do
    case $OPTION in
        q) export QUERY_SCRIPT=$OPTARG;;
        i) export INC_DIR=$OPTARG;;
        c) if [[ -e "$OPTARG" ]]; then 
                . $OPTARG
           else
             echo "Configuration file $OPTARG does not exist"
             exit
           fi;;
	d) if (date -d "$OPTARG" +"%Y%m%d"); then 
	 	export DATE_TODAY=$OPTARG
	else 
		echo "bad date format, needs to be %Y%m%d"
		exit
	fi;;
	t) export DATE_TODAY=$(date +"%Y%m%d%H%M%S");;
	u) export TERADATA_USERNAME=$OPTARG;;
	p) export TERADATA_PASSWORD=$OPTARG;;
	s) export TERADATA_HOST=$OPTARG;;
        h) usage
           exit
         ;;
        ?) usage
           exit
         ;;
    esac
done


DATE_TODAY=${DATE_TODAY:-$(date +"%Y%m%d")}
TMP_TBL=${QUERY_SCRIPT##/*/}    # remove the directory path
TMP_TBL=${TMP_TBL%%.*}          # remove period and extension of the filename


work_dir=/staging/$USER
script_dir=/appl/$USER/scripts
log_dir=/logs/$USER
log_file=$log_dir/${TMP_TBL}_${DATE_TODAY}.log
echo $DATE_TODAY
export DATE_TODAY
export work_dir
export TMP_TBL

#Execute Extraction job

# ================
# Validation check
# ================

if [[ -z $INC_DIR ]] || [[ -z $QUERY_SCRIPT ]]
then
     usage
     exit 1
fi

if [[ ! -s $QUERY_SCRIPT ]];then
    RC=1
    echo "ERROR - Fast Export script $QUERY_SCRIPT does not exist.  Command:  $0 $*" 
    exit $RC
fi


  hadoop fs -test -d $INC_DIR 2>/dev/null
  RC=$?
  if [[ $RC -ne 0 ]];then
       echo "ERROR - Incoming directory $INC_DIR does not exist.  Command:  $0 $*" 
    exit $RC
  fi

#

if [[ -z $TERADATA_USERNAME ]]; then
  echo  "ERROR: TERADATA_USERNAME environment variable needs to be set"
  exit 1
fi

if [[ -z $TERADATA_PASSWORD ]]; then
  echo  "ERROR: TERADATA_PASSWORD environment variable needs to be set"
  exit 1
fi

OUTFILE=/staging/$USER/${TMP_TBL}_${DATE_TODAY}.txt

log_init $log_file a

log "INFO:START ${TMP_TBL}_daily extract"

fexp <<EOF 

.ROUTE MESSAGES ECHO FILE $log_file;                                                                         

.LOGON $TERADATA_HOST/$TERADATA_USERNAME,$TERADATA_PASSWORD;
.LOGTABLE SHC_WORK_TBLS.fexp_$TMP_TBL;

.BEGIN EXPORT SESSIONS 20;                                               
.EXPORT OUTFILE /staging/$USER/${TMP_TBL}_${DATE_TODAY}.txt                                
FORMAT TEXT MODE RECORD;                                                        
                                                             
.RUN FILE $QUERY_SCRIPT;          

.END EXPORT;
.LOGOFF;

EOF

RC=$?

  if [ $RC -ne 0 ];
  then
    log "ERROR - Fast Export Failed for script $QUERY_SCRIPT with return code $RC" 
    exit $RC

  else
    log "INFO - Fast Export Successful for script $QUERY_SCRIPT" 
  fi


log "INFO:END ${TMP_TBL}_daily extract"
### load extracted file to HDFS
log "INFO:PUT ${TMP_TBL}_daily extract to HDFS"

hput /staging/$USER/${TMP_TBL}_${DATE_TODAY}.txt $INC_DIR/. 

RC=$?

if [ $RC -ne 0 ];
  then
    log "ERROR - Move to HDFS failed for $OUTFILE to $INC_DIR with return code $RC" 
    exit $RC
  else
    echo "INFO - Move to HDFS successful for $OUTFILE to $INC_DIR" 
  fi


#count=$(hcat $INC_DIR/${TMP_TBL}_${DATE_TODAY}.txt | wc -l)
count=$(hlncount $INC_DIR/${TMP_TBL}_${DATE_TODAY}.txt)
log "INFO:RECORD COUNT in ${TMP_TBL}_${DATE_TODAY}.txt :  ${count}"
log "INFO:END ${TMP_TBL}_daily extract"
