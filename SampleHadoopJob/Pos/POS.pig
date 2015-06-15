SET DEFAULT_PARALLEL 20;
REGISTER '/home/auto/smoham3/scripts/pig_concat.jar';
srs_soar_bu = LOAD ' /work/syw_member_repo/Telluride/rd_srs_soar_bu_1' using PigStorage('\u0001') AS(
CreateTs:chararray,
  itm_no :chararray
      ,div_no :chararray
      ,div_nm :chararray
      ,soar_no :chararray
      ,soar_nm :chararray
      ,ln_no :chararray
      ,ln_ds :chararray
      ,sbl_no :chararray
      ,sbl_ds :chararray
      ,prd_ds :chararray
);

Kmt_Soar_Bu = LOAD ' /work/syw_member_repo/Telluride/Rd_Kmt_Soar_Bu_1' using PigStorage('\u0001') AS(
CreateTs:chararray,
SOAR_NO :chararray
        ,SOAR_NM :chararray
        ,FP_UNIT_NBR :chararray
        ,FP_UNIT_DESC :chararray
        ,FP_DVSN_NBR :chararray
        ,FP_DVSN_DESC :chararray
        ,FP_DEPT_NBR :chararray
        ,FP_DEPT_DESC :chararray
        ,FP_CATG_GRP_NBR:chararray
        ,FP_CATG_GRP_DESC :chararray
        ,CATG_NBR  :chararray
        ,CATG_DESC :chararray
        ,sub_catg_nbr :chararray
        ,sub_catg_desc  :chararray
        ,KSN_ID    :chararray
        ,KSN_DESC :chararray
        ,REPT_COST_AMT :chararray

);


SrsSlsPtd = LOAD '/smith/syw_member_repo/Telluride/SywrSrsSlsPtdMstrCrm' using PigStorage('\u0001') AS(
CreateTs:chararray
,CustIntractnId:chararray
,TranLnNbr:chararray
,LyltyCardNbr:chararray
,TranDt:chararray
,FacilIdNbr:chararray
,FacilSbtCd:chararray
,DivNbr:chararray
,ItemNbr:chararray
,SoarNbr:chararray
,LnItemTranTypeCd:chararray
,CostPerUnit:chararray
,ItemRegPrcAmt:chararray
,PluAmtTypCd:chararray
,GrsSls:chararray
,MrkdnAmt:chararray
,ProdQty:chararray
,BurnAmt:chararray
,MerchCogs:chararray
,NetMerchSls:chararray
,Mrgn:chararray
,MscAcctNbr:chararray
,OnlineOrdId:chararray);

KmtSlsPtd = LOAD ' /work/syw_member_repo/Telluride/SywrKmtSlsPtdMstrCrm_oneyr_' using PigStorage('\u0001') AS(CreateTs:chararray
,CustIntractnId:chararray
,SaleSeqNbr:chararray
,LyltyCardNbr:chararray
,TranDt:chararray
,LocnNbr:chararray
,KsnId:chararray
,SoarNbr:chararray
,SellTypeCd:chararray
,SkuPrcTypeCd:chararray
,OnlineOrdId:chararray
,KmtSell:chararray
,MrkdnAmt:chararray
,SlsQty:chararray
,MerchCogs:chararray
,Mrgn:chararray
,BurnAmt:chararray
,MygoferOrderInd:chararray);




ShcSoarBu = LOAD '/work/syw_member_repo/Telluride/ShcSoarBu' using PigStorage('\u0001') AS
(CreateTs:chararray
,ShcSoarNbr:chararray
        ,ShcSoarNm:chararray
        ,SrsSoarNbr:chararray
        ,KmtSoarNbr:chararray
        ,RowCreatTs:chararray
        ,RowCreatUserId:chararray
        ,RowModTs:chararray
        ,RowModUserId:chararray);



SrsSlsPtdReq = FILTER SrsSlsPtd BY FacilSbtCd IN ('A','B','C','D','G1','G2','N1','N2','N4','M') AND DivNbr !='0' AND DivNbr !='79';

srs_year = FILTER SrsSlsPtdReq BY ToDate(TranDt,'yyyy-MM-dd')>= ToDate('2013-12-01','yyyy-MM-dd')AND ToDate(TranDt,'yyyy-MM-dd')<= ToDate('2014-12-01','yyyy-MM-dd') AND (LyltyCardNbr IS NOT NULL);
kmt_year = FILTER KmtSlsPtd BY ToDate(TranDt,'yyyy-MM-dd')>= ToDate('2013-12-01','yyyy-MM-dd')AND ToDate(TranDt,'yyyy-MM-dd')<= ToDate('2014-12-01','yyyy-MM-dd') AND (LyltyCardNbr IS NOT NULL);

float_SlsSrs_yr = FOREACH srs_year GENERATE (FLOAT) NetMerchSls,DivNbr,ItemNbr,LyltyCardNbr,TranDt;

joinSlsSrs_year = JOIN float_SlsSrs_yr BY (DivNbr,ItemNbr), srs_soar_bu BY (div_no,itm_no);

groupSlsSrs_year = GROUP joinSlsSrs_year BY float_SlsSrs_yr::LyltyCardNbr;

SrsSoar_nm = FOREACH groupSlsSrs_year {
A = DISTINCT joinSlsSrs_year. srs_soar_bu::soar_nm;
GENERATE
group as LyltyCardNbr, 
org.sears.concat.Concat_Tuple(A) as srs_soar_bu;};

--Kmt

float_SlsKmt_yr = FOREACH kmt_year GENERATE (FLOAT)KmtSell-(FLOAT)MrkdnAmt  as NetMerchSls,KsnId,LyltyCardNbr,TranDt;

joinSlsKmt_year = JOIN float_SlsKmt_yr BY KsnId, Kmt_Soar_Bu BY KSN_ID;
groupSlsKmt_year = GROUP joinSlsKmt_year
BY float_SlsKmt_yr::LyltyCardNbr;

KmtSoar_nm = FOREACH groupSlsKmt_year {
A = DISTINCT joinSlsKmt_year. Kmt_Soar_Bu::SOAR_NM;
GENERATE
group as LyltyCardNbr, 
org.sears.concat.Concat_Tuple(A) as kmt_soarbu_nm;};

--SHC

joinshcsrs_soar = JOIN joinSlsSrs_year BY srs_soar_bu::soar_no, ShcSoarBu BY SrsSoarNbr;
groupshcsrs = GROUP joinshcsrs_soar BY (joinSlsSrs_year::float_SlsSrs_yr::LyltyCardNbr);
foreach_groupshcsrs = FOREACH groupshcsrs {
A = DISTINCT joinshcsrs_soar.ShcSoarBu::ShcSoarNm;
GENERATE
group as LyltyCardNbr,
org.sears.concat.Concat_Tuple(A) as ShcSoarNm,
MAX(joinshcsrs_soar.joinSlsSrs_year::float_SlsSrs_yr::TranDt) as TranDt;};

joinshckmt_soar = JOIN joinSlsKmt_year BY Kmt_Soar_Bu::SOAR_NO, ShcSoarBu BY KmtSoarNbr;
groupshckmt = GROUP joinshckmt_soar BY (joinSlsKmt_year::float_SlsKmt_yr::LyltyCardNbr);
foreach_groupshckmt = FOREACH groupshckmt {
A = DISTINCT joinshckmt_soar. ShcSoarBu::ShcSoarNm;
GENERATE
group as LyltyCardNbr,
org.sears.concat.Concat_Tuple(A) as ShcSoarNm,
MAX(joinshckmt_soar.joinSlsKmt_year::float_SlsKmt_yr::TranDt) as TranDt;};

unionshc_soar = UNION foreach_groupshcsrs, foreach_groupshckmt;

group_unionshc_soar = GROUP unionshc_soar BY LyltyCardNbr;

foreach_group_unionshc_soar = FOREACH group_unionshc_soar
GENERATE
group as LyltyCardNbr,
org.sears.concat.Concat_Tuple(unionshc_soar.ShcSoarNm) as ShcSoarNm,MAX(unionshc_soar.TranDt) as TranDt;

--union

join_soar_bu = JOIN SrsSoar_nm BY LyltyCardNbr FULL, KmtSoar_nm BY LyltyCardNbr;

foreach_join_soar_bu = FOREACH join_soar_bu GENERATE 
(CASE WHEN (SrsSoar_nm::LyltyCardNbr) IS NULL THEN KmtSoar_nm::LyltyCardNbr ELSE
 SrsSoar_nm::LyltyCardNbr END)as LyltyCardNbr, 
SrsSoar_nm::srs_soar_bu as srs_soar_bu,
KmtSoar_nm::kmt_soarbu_nm as kmt_soar_bu;

join_soar_bu_1 = JOIN foreach_join_soar_bu BY LyltyCardNbr FULL, foreach_group_unionshc_soar BY LyltyCardNbr;

foreach_join_soar_bu_1 = FOREACH join_soar_bu_1 GENERATE (CASE WHEN foreach_join_soar_bu::LyltyCardNbr IS NULL THEN foreach_group_unionshc_soar::LyltyCardNbr ELSE foreach_join_soar_bu::LyltyCardNbr END) as LyltyCardNbr, 
foreach_join_soar_bu::srs_soar_bu as srs_soar_bu,
foreach_join_soar_bu::kmt_soar_bu as kmt_soar_bu,
foreach_group_unionshc_soar::ShcSoarNm as shc_soar_bu,
foreach_group_unionshc_soar::TranDt as TranDt;

STORE foreach_join_soar_bu_1 into '/smith/syw_member_repo/Telluride/POS' using PigStorage('\\u0001');


