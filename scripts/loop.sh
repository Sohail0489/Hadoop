

FROM_DATE=('2012-01-01' '2013-01-01' '2014-01-01')
TO_DATE=('2012-12-31' '2013-12-31' '2014-12-31')


for ((j=0; j<3; j++))
do
	echo `sed -e "s|FROM_DATE|"${FROM_DATE[j+3]}"|g" -e "s|TO_DATE|"${TO_DATE[j+3]}"|g" -e "s|COUNT|"${j+3}"|g" < L2_SelfServAnlysEngineDev_S.SywrSrsSlsPtdMstrCrm.fexp > TEMP.fexp`
	echo `fexp < TEMP.fexp`
	echo `sudo -u mapadmin hadoop fs -copyFromLocal /staging/analytics/map/input/Telluride/L2_SelfServAnlysEngineDev_S.SywrSrsSlsPtdMstrCrm_${j+3}.out /incoming/map/L2_SelfServAnlysEngineDev_S.SywrSrsSlsPtdMstrCrm/`
	echo `sudo -u mapadmin rm /staging/analytics/map/input/Telluride/L2_SelfServAnlysEngineDev_S.SywrSrsSlsPtdMstrCrm_${j+3}.out`
done
