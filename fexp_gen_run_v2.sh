#!/bin/bash

#####################################################################################################################################
#       fexp_gen_run.sh
#       Usage: fexp_gen_run.sh -q/p/P -o Outputfile -t Tablename
#
#  Changes         User                 Description
#------------------------------------------------------------------------------------
#  10/2014         jmario1              Added option -P for Teradata 1700
#                                       Added obtaining script directory path so script can
#                                       be run from any directory
#                                       Added reading TERADATA_USERNAME and TERADATA_PASSWORD from
#                                       commandline if environment variables not set
#                                       Changed the CLASSPATH to teradata jar files
#                                       Exported the TERADATA_USERNAME TERADATA_PASSWORD and TERADATA_ENV values so
#                                       they are picked up by the next script
#####################################################################################################################################

SCRIPTS_DIR=$(dirname $(readlink -f $0))
echo $SCRIPTS_DIR

usage() {
  cat <<EOF
  usage : $0  -q/-p/P -o Output File (optional) -t Tablename
  Script to run Teradata extracts
  OPTIONS:
        Mandatory
        -t      Tablename
        -q/-p/-P      QA Teradata environment or Production 6690 Teradata environment or Production 1700 Teradata environment
        Optional
        -o      Redirect the output to a output file
        -h      Show this message
EOF
}

while getopts "t:qpiPo:h:" OPTION
do
    case $OPTION in
        t) TABLENAME=$OPTARG;;
        q) export TERADATA_ENV=edwtest1.intra.searshc.com;;
        p) export TERADATA_ENV=edwprod1cop1.intra.searshc.com;;
        P) export TERADATA_ENV=tdadhoc.intra.searshc.com;;
        o) export OUTPUT_FILE=$OPTARG;;
        h) usage
           exit
         ;;
        ?) usage
           exit
         ;;
    esac
done

#Check if the user has entered the table name
if [[ -z $TABLENAME ]];
then
{
 echo "Please enter the tablename"
 usage
 exit 
}
fi

#Check if the user has specified which environment he wishes to use (QA/Prod)
if [[ -z $TERADATA_ENV ]];
then
{
 echo "Please enter which teradata environment you wish to use"
 usage
 exit
}
fi

#Setting the environment and adding drivers
#export TERADATA_ENV=edwprod1cop1.intra.searshc.com
#export TERADATA_ENV=edwtest1.intra.searshc.com
export CLASSPATH=$CLASSPATH:/usr/share/java/terajdbc4.jar:/usr/share/java/tdgssconfig.jar

#Checking if the Teradata_userame environment variable is set
if [[ -z $TERADATA_USERNAME ]];
then
{
 echo "Please set the TERADATA_USERNAME environment variable"
 read username
 if [[ -z $username ]];
 then
 {  
   echo "Error on enter username"
   exit
 }
 fi
 export TERADATA_USERNAME=$username
}
fi

#Checking if the Teradata_password environment variable is set
if [[ -z $TERADATA_PASSWORD ]];
then
{
 echo "Please set the TERADATA_PASSWORD environment variable"
 read -s password
 if [[ -z $password ]];
 then
 {
   echo "Error on enter password"
   exit
 }
 fi
 export TERADATA_PASSWORD=$password
}
fi

echo "Accessing table definition for $TABLENAME on $TERADATA_ENV"

#Check if the user wants the output to be redirected to a file
if [[ -z $OUTPUT_FILE ]];
then
{
$SCRIPTS_DIR/fexp_gen.rb $TABLENAME
}
else
{
$SCRIPTS_DIR/fexp_gen.rb $TABLENAME >> $OUTPUT_FILE
}
fi
echo "End of table generator"
