REGISTER /home/auto/smoham3/samy_scripts/pig_concat_sam.jar;
srsslsptd = LOAD '/work/map/weeklyrefresh/pos/SywrSrsSlsPtdMstrCrm/part-m-00001' using PigStorage ('\u0001') AS
--srsslsptd = LOAD '/work/map/weeklyrefresh/pos/SywrSrsSlsPtdMstrCrm' using PigStorage ('\u0001') AS
(
TimeStamp : chararray
,CustIntractnId :chararray
,TranLnNbr :chararray
,LyltyCardNbr :chararray
,TranDt :chararray
,FacilIdNbr :chararray
,FacilSbtCd :chararray
,DivNbr :chararray
,ItemNbr :chararray
,SoarNbr :chararray
,LnItemTranTypeCd :chararray
,CostPerUnit :chararray
,ItemRegPrcAmt :chararray
,PluAmtTypCd :chararray
,GrsSls :chararray

,MrkdnAmt :chararray
,ProdQty :chararray
,BurnAmt :chararray
,MerchCogs :chararray
,NetMerchSls :chararray
,Mrgn :chararray
,MscAcctNbr :chararray
,OnlineOrdId :chararray
);
kmtslsptd = LOAD '/work/map/weeklyrefresh/pos/SywrKmtSlsPtdMstrCrm/part-m-00001' using PigStorage ('\u0001') AS
--kmtslsptd = LOAD '/work/map/weeklyrefresh/pos/SywrKmtSlsPtdMstrCrm' using PigStorage ('\u0001') AS
(
TimeStamp : chararray
,CustIntractnId : chararray
,SaleSeqNbr : chararray
,LyltyCardNbr : chararray
,TranDt : chararray
,LocnNbr : chararray
,KsnId : chararray
,SoarNbr : chararray
,SellTypeCd : chararray
,SkuPrcTypeCd : chararray
,OnlineOrdId : chararray
,KmtSell : chararray
,MrkdnAmt : chararray
,SlsQty : chararray
,MerchCogs : chararray
,Mrgn : chararray
,BurnAmt : chararray
,MygoferOrderInd : chararray

);
srssorbu = LOAD '/work/map/weeklyrefresh/sywinteractions/sears' using PigStorage ('\u0001') AS
(
TimeStamp : chararray
,ItemNbr : chararray
,DivNbr : chararray
,DivNm : chararray
,SoarBuNbr : chararray
,SoarBuNm : chararray
,LnNbr : chararray
,LnDesc : chararray
,SubLnNbr : chararray
,SubLnDesc : chararray
,ProdDesc : chararray
,RowCrtTs : chararray
,RowModTs : chararray
);

-------------------------------------------

srsA = FILTER srsslsptd by (LyltyCardNbr IS NOT NULL) and FacilSbtCd  IN ('A','B','C','D','G1','G2','N1','N2','N4','M') 
AND  DivNbr !='0' AND DivNbr !='79' AND (LONG)YearsBetween(CurrentTime(),ToDate(TranDt,'yyyy-MM-dd HH:mm:ss'))<=1;

srsB = join srsA by (DivNbr,ItemNbr), srssorbu BY (DivNbr,ItemNbr);

srsC = GROUP srsB BY LyltyCardNbr;

srsD = foreach srsC { 
    unique_soar_nm = DISTINCT srsB.srssorbu::SoarBuNm;
	
    Z = pig_conact_sam_pkg.CustomConcatSam(unique_soar_nm);

    generate group as LyltyCardNbr, Z as str, MAX(srsB.srsA::TranDt) as trdt;
};


srsE = FOREACH srsD GENERATE LyltyCardNbr,str as srs_bu,ToDate(trdt,'yyyy-MM-dd HH:mm:ss','UTC') as UTCTIME;

-----------------------------------------------------------
kmtsorbu = LOAD '/work/map/weeklyrefresh/sywinteractions/kmt' using PigStorage ('\u0001') AS
(
TimeStamp : chararray
,SOAR_NO : chararray
,SOAR_NM : chararray
,FP_UNIT_NBR : chararray
,FP_UNIT_DESC : chararray
,FP_DVSN_NBR : chararray
,FP_DVSN_DESC : chararray
,FP_DEPT_NBR : chararray
,FP_DEPT_DESC : chararray
,FP_CATG_GRP_NBR : chararray
,FP_CATG_GRP_DESC : chararray
,CATG_NBR : chararray
,CATG_DESC : chararray
,sub_catg_nbr : chararray
,sub_catg_desc : chararray
,KSN_ID : chararray
,KSN_DESC : chararray
,REPT_COST_AMT : chararray
);

kmtA = FILTER kmtslsptd by (LyltyCardNbr IS NOT NULL)
and (LONG)YearsBetween(CurrentTime(),ToDate(TranDt,'yyyy-MM-dd HH:mm:ss'))<=1;

kmtB = join kmtA by KsnId, kmtsorbu by KSN_ID;

kmtC = GROUP kmtB  BY LyltyCardNbr;

kmtD = foreach kmtC {
    unique_soar_nm = DISTINCT kmtB.kmtsorbu::SOAR_NM;
    Z = pig_conact_sam_pkg.CustomConcatSam(unique_soar_nm);

    generate group as LyltyCardNbr, Z as str, MAX(kmtB.kmtA::TranDt) as trdt;

};
kmtE = FOREACH kmtD GENERATE LyltyCardNbr,str as kmt_bu,ToDate(trdt,'yyyy-MM-dd HH:mm:ss','UTC') as UTCTIME;


--------------------------------------------------------
--shcsorbu = LOAD '/user/smoham3/test_scripts/ShcSoarBu' using PigStorage ('\u0001') AS
shcsorbu = LOAD '/work/map/weeklyrefresh/pos/ShcSoarBu' using PigStorage ('\u0001') AS
(
TimeStamp : chararray
,ShcSoarNbr : chararray
,ShcSoarNm : chararray
,SrsSoarNbr : chararray
,KmtSoarNbr : chararray
,RowCreatTs : chararray
,RowCreatUserId : chararray
,RowModTs : chararray
,RowModUserId : chararray
);

shcz = group shcsorbu by (ShcSoarNbr,SrsSoarNbr,KmtSoarNbr,ShcSoarNm);

shcza = FOREACH shcz GENERATE group.ShcSoarNbr,group.SrsSoarNbr,group.KmtSoarNbr, group.ShcSoarNm;

--distinct card,bunbr pairs
srstransc = FOREACH (GROUP srsA by (LyltyCardNbr,SoarNbr) ) {
			GENERATE group.LyltyCardNbr,group.SoarNbr;
};
--distinct card,bunbr pairs
kmttransc = FOREACH (GROUP kmtA by (LyltyCardNbr,SoarNbr ) ) {
			GENERATE group.LyltyCardNbr,group.SoarNbr;
};

--jsrskmt = join srstransc by $0, kmttransc by $0;
jsrs_shcza = FOREACH (join srstransc by SoarNbr, shcza by SrsSoarNbr) GENERATE srstransc::LyltyCardNbr,shcza::ShcSoarNm ;
jkmt_shcza = FOREACH (join kmttransc by SoarNbr, shcza by KmtSoarNbr) GENERATE kmttransc::LyltyCardNbr,shcza::ShcSoarNm ;

usrs_kmt = union jsrs_shcza , jkmt_shcza;
unique_usrs_kmt = distinct usrs_kmt;

shcf = foreach (GROUP unique_usrs_kmt by srstransc::LyltyCardNbr ){ 
    	str2 = pig_conact_sam_pkg.CustomConcatSam(unique_usrs_kmt.shcza::ShcSoarNm);

    	generate group as LyltyCardNbr, str2 as Str;
};
res1 = union srsE, kmtE;

res1_1 = FOREACH (Group res1 by LyltyCardNbr) GENERATE group as LyltyCardNbr,MAX(res1.UTCTIME) as trandt;
--res2 = FOREACH (join srsE by LyltyCardNbr FULL, kmtE by LyltyCardNbr) GENERATE 
--(CASE WHEN srsE::LyltyCardNbr IS NULL THEN kmtE::LyltyCardNbr else srsE::LyltyCardNbr END),kmtE::kmt_bu,srsE.srs_bu;

--res2_2 = FOREACH (join res2 by LyltyCardNbr,res1_1 by LyltyCardNbr) 
--GENERATE res2.kmtE::LyltyCardNbr, res2::kmt_bu, res2::srs_bu, res1_1::trandt;

--res3 = FOREACH (join res2_2 by LyltyCardNbr, shcf by LyltyCardNbr) 
--GENERATE res2_2::LyltyCardNbr,res2_2::kmt_bu,res2_2::srs_bu,res2_2::trandt,shcf::Str;

--STORE res3 INTO '/user/smoham3/test_scripts/result28.1' using PigStorage('\t');

res2 = FOREACH (join srsE by LyltyCardNbr FULL, kmtE by LyltyCardNbr) GENERATE (CASE WHEN srsE::LyltyCardNbr IS NULL THEN kmtE::LyltyCardNbr else srsE::LyltyCardNbr END) as Ki,kmtE::kmt_bu,srsE::srs_bu;

res2_2 = FOREACH (join res2 by Ki,res1_1 by LyltyCardNbr) GENERATE res2::Ki, res2::kmtE::kmt_bu, res2::srsE::srs_bu, res1_1::trandt;

res3 = FOREACH (join res2_2 by res2::Ki, shcf by LyltyCardNbr) GENERATE res2_2::res2::Ki,res2_2::res2::kmtE::kmt_bu,res2_2::res2::srsE::srs_bu,res2_2::res1_1::trandt,shcf::Str;

STORE res3 INTO '/user/smoham3/test_scripts/result28.2' using PigStorage('\t');


