bteq << EOF 2>&1 > log
.LOGON tdadhoc.intra.searshc.com/smoham3,password
DATABASE ${MAP_SRC_VIEWS_DB};
.set width 2000;
.set titledashes off;
SELECT '>'||count(A.LyltyCardNbr) FROM
(select * from L2_MAPSrcViews_S.ViSegMbrTyLyV3
QUALIFY ROW_NUMBER() OVER(PARTITION BY LyltyCardNbr ORDER BY MthNbr desc)=1
 where LyltyCardNbr>0 )A;
.LOGOFF;
.QUIT;
.EXIT
EOF
count_export=$(cat log|grep '^>' |sed -e "s/^>//")
echo $count_export
count_staging=$(hadoop fs -cat /warehouse/map_repo/incoming/InferredInternal/Segments/20150325|wc -l )
echo $count_staging
if [ $count_export == $count_staging ]
then
echo match
else
echo "count dint match for inferred!"
	exit 1
fi
