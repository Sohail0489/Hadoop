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

KmtSlsPtd = LOAD '/work/syw_member_repo/Telluride/SywrKmtSlsPtdMstrCrm_oneyr_' using PigStorage('\u0001') AS(CreateTs:chararray
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



KillVertSrs = LOAD '/work/syw_member_repo/KillVert/KillVertSrs_1' using PigStorage('\u0001') AS
(CreateTs:chararray,
KillVertNm :chararray,
KillVertNbr :chararray,
KillVertSubNm :chararray,
KeyWordFill :chararray,
ItemNbr :chararray,
DivNbr :chararray,
DivDesc :chararray,
LnNbr :chararray,
LnDesc :chararray,
SblnNbr :chararray,
SblnDesc :chararray,
ProdDesc :chararray,
ChgDt :chararray);

KillVertKmt = LOAD  '/work/syw_member_repo/KillVert/KillVertKmt_1' using PigStorage('\u0001') AS
(CreateTs:chararray,
KillVertNm  :chararray,
 KillVertNbr  :chararray,
 KillVertSubNm  :chararray,
 FinanDvsnNbr :chararray,
 FinanDvsnDesc :chararray,
 FinanDeptNbr :chararray,
 FinanDeptDesc :chararray,
 FinanCatgGrpNbr :chararray,
 FinanCatgGrpDesc :chararray,
 CatgNbr    :chararray,
 CatgDesc   :chararray,
 SubCatgNbr :chararray,
 SubCatgDesc  :chararray,
 KsnId :chararray,
 KsnDesc :chararray,
 RptCostAmt :chararray,
 KeyWordFill :chararray,
 ChgDt :chararray);

SrsSlsPtdReq = FILTER SrsSlsPtd BY FacilSbtCd IN ('A','B','C','D','G1','G2','N1','N2','N4','M') AND DivNbr !='0' AND DivNbr !='79';

srs_year = FILTER SrsSlsPtdReq BY ToDate(TranDt,'yyyy-MM-dd')>= ToDate('2013-12-01','yyyy-MM-dd')AND ToDate(TranDt,'yyyy-MM-dd')<= ToDate('2014-12-01','yyyy-MM-dd') AND (LyltyCardNbr IS NOT NULL);
kmt_year = FILTER KmtSlsPtd BY ToDate(TranDt,'yyyy-MM-dd')>= ToDate('2013-12-01','yyyy-MM-dd')AND ToDate(TranDt,'yyyy-MM-dd')<= ToDate('2014-12-01','yyyy-MM-dd') AND (LyltyCardNbr IS NOT NULL);

float_SlsSrs_yr = FOREACH srs_year GENERATE DivNbr,ItemNbr,LyltyCardNbr,TranDt;

joinSlsSrs_year = JOIN float_SlsSrs_yr BY (DivNbr,ItemNbr), srs_soar_bu BY (div_no,itm_no);

----killvertical
srs_killver = join float_SlsSrs_yr BY (DivNbr,ItemNbr), 
KillVertSrs BY (DivNbr,ItemNbr);

----

groupsrskill = GROUP srs_killver BY float_SlsSrs_yr::LyltyCardNbr;

srs_killVert_year = FOREACH groupsrskill
GENERATE 
group as LyltyCardNbr,
org.sears.concat.Concat_Tuple(srs_killver.KillVertSrs::KillVertNm) as KillVertNm;

foreach_SlsSrs_year = FOREACH joinSlsSrs_year{
A = CONCAT(srs_soar_bu::soar_nm,CONCAT('-',srs_soar_bu::div_nm));
GENERATE 
float_SlsSrs_yr::LyltyCardNbr as LyltyCardNbr,
srs_soar_bu::soar_nm as soar_nm,
A as div_ds,
CONCAT(A,CONCAT('-',srs_soar_bu::ln_ds)) as ln_ds;};



groupSlsSrs_year = GROUP foreach_SlsSrs_year BY LyltyCardNbr;


SrsSoar_nm = FOREACH groupSlsSrs_year
GENERATE
group as LyltyCardNbr, 
org.sears.concat.Concat_Tuple(foreach_SlsSrs_year.soar_nm) as srs_soar_bu,
org.sears.concat.Concat_Tuple(foreach_SlsSrs_year.div_ds) as srs_div_nm,
org.sears.concat.Concat_Tuple(foreach_SlsSrs_year.ln_ds) as srs_ln_ds;
--Kmt

float_SlsKmt_yr = FOREACH kmt_year GENERATE KsnId,LyltyCardNbr,TranDt;

joinSlsKmt_year = JOIN float_SlsKmt_yr BY KsnId, Kmt_Soar_Bu BY KSN_ID;

--------kmtkiller ver
kmt_killver = join float_SlsKmt_yr BY KsnId,
KillVertKmt BY KsnId;
--------

foreach_joinSlsKmt_year = FOREACH joinSlsKmt_year GENERATE
float_SlsKmt_yr::LyltyCardNbr as LyltyCardNbr,
Kmt_Soar_Bu::FP_DVSN_DESC as FP_DVSN_DESC,
Kmt_Soar_Bu::FP_DEPT_NBR as FP_DEPT_NBR,
Kmt_Soar_Bu::FP_CATG_GRP_DESC as FP_CATG_GRP_DESC,
Kmt_Soar_Bu::SOAR_NM as SOAR_NM;

groupkmtkill = GROUP kmt_killver BY float_SlsKmt_yr::LyltyCardNbr;

kmt_killVert_year = FOREACH groupkmtkill
GENERATE 
group as LyltyCardNbr,
org.sears.concat.Concat_Tuple(kmt_killver.KillVertKmt::KillVertNm) as KillVertNm;


------join kmt & srs killVertNm
join_kmtsrsKillVert = join srs_killVert_year by LyltyCardNbr FULL, kmt_killVert_year by LyltyCardNbr;

foreach_kmtsrskilvert = FOREACH join_kmtsrsKillVert GENERATE
(CASE WHEN srs_killVert_year::LyltyCardNbr IS NULL THEN kmt_killVert_year::LyltyCardNbr ELSE srs_killVert_year::LyltyCardNbr END) as LyltyCardNbr,
srs_killVert_year::KillVertNm as srs_KillVertNm,
kmt_killVert_year::KillVertNm as kmt_KillVertNm;

------

----table for distinct FP_CATG_GRP_DESC and min FP_DEPT_NBR--
group_CATG_DEPT = GROUP Kmt_Soar_Bu BY FP_CATG_GRP_DESC;

foreach_CATG_DEPT = FOREACH group_CATG_DEPT GENERATE
group as FP_CATG_GRP_DESC,CONCAT(MIN(Kmt_Soar_Bu.FP_DEPT_NBR),CONCAT(' ',group))as FP_DEPT_NBR_CATG; 
-----

join_KmtSoar_CATG_DEPT = join foreach_joinSlsKmt_year BY FP_CATG_GRP_DESC, foreach_CATG_DEPT  BY FP_CATG_GRP_DESC;

foreach_KmtSoar_CATG_DEPT = FOREACH join_KmtSoar_CATG_DEPT {
A = CONCAT($4,CONCAT('-',$1));
GENERATE
$0 as LyltyCardNbr,
A as FP_DVSN_DESC,
$4 as SOAR_NM,
CONCAT(A, CONCAT('-',$6)) as FP_DEPT_NBR_CATG;};

groupSlsKmt_year = GROUP foreach_KmtSoar_CATG_DEPT
BY LyltyCardNbr;

KmtSoar_nm = FOREACH groupSlsKmt_year {
A = DISTINCT foreach_KmtSoar_CATG_DEPT.SOAR_NM;
B = DISTINCT foreach_KmtSoar_CATG_DEPT.FP_DEPT_NBR_CATG;
C = DISTINCT foreach_KmtSoar_CATG_DEPT.FP_DVSN_DESC;
GENERATE
group as LyltyCardNbr, 
org.sears.concat.Concat_Tuple(A) as kmt_soarbu_nm,
org.sears.concat.Concat_Tuple(C) as kmt_div_desc,
org.sears.concat.Concat_Tuple(B) as kmt_line_desc;};
--SHC

joinshcsrs_soar = JOIN joinSlsSrs_year BY srs_soar_bu::soar_no, ShcSoarBu BY SrsSoarNbr;


foreach_groupshcsrs = FOREACH joinshcsrs_soar GENERATE joinSlsSrs_year::float_SlsSrs_yr::LyltyCardNbr as LyltyCardNbr,
joinSlsSrs_year::float_SlsSrs_yr::TranDt as TranDt,
ShcSoarBu::ShcSoarNm as ShcSoarNm;

joinshckmt_soar = JOIN joinSlsKmt_year BY Kmt_Soar_Bu::SOAR_NO, ShcSoarBu BY KmtSoarNbr;


foreach_groupshckmt = FOREACH joinshckmt_soar GENERATE joinSlsKmt_year::float_SlsKmt_yr::LyltyCardNbr as LyltyCardNbr,
joinSlsKmt_year::float_SlsKmt_yr::TranDt as TranDt,
ShcSoarBu::ShcSoarNm as ShcSoarNm;


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
SrsSoar_nm::srs_div_nm as srs_dv_ds,
SrsSoar_nm::srs_ln_ds as srs_ln_ds,
KmtSoar_nm::kmt_soarbu_nm as kmt_soar_bu,
KmtSoar_nm::kmt_div_desc as kmt_div_ds,
KmtSoar_nm::kmt_line_desc as kmt_ln_ds;

join_soar_bu_1 = JOIN foreach_join_soar_bu BY LyltyCardNbr FULL, foreach_group_unionshc_soar BY LyltyCardNbr;

foreach_join_soar_bu_1 = FOREACH join_soar_bu_1 GENERATE (CASE WHEN foreach_join_soar_bu::LyltyCardNbr IS NULL THEN foreach_group_unionshc_soar::LyltyCardNbr ELSE foreach_join_soar_bu::LyltyCardNbr END) as LyltyCardNbr, 
foreach_join_soar_bu::srs_soar_bu as srs_soar_bu,
foreach_join_soar_bu::srs_dv_ds as srs_dv_ds,
foreach_join_soar_bu::srs_ln_ds as srs_ln_ds,
foreach_join_soar_bu::kmt_soar_bu as kmt_soar_bu,
foreach_join_soar_bu::kmt_div_ds as kmt_div_ds,
foreach_join_soar_bu::kmt_ln_ds as kmt_ln_ds,
foreach_group_unionshc_soar::ShcSoarNm as shc_soar_bu,
foreach_group_unionshc_soar::TranDt as TranDt;


join_final_kill = JOIN foreach_join_soar_bu_1 BY LyltyCardNbr FULL, foreach_kmtsrskilvert BY LyltyCardNbr;

foreach_final = FOREACH join_final_kill GENERATE (CASE WHEN foreach_join_soar_bu_1::LyltyCardNbr IS NULL THEN foreach_kmtsrskilvert::LyltyCardNbr ELSE foreach_join_soar_bu_1::LyltyCardNbr END) as LyltyCardNbr, 
foreach_join_soar_bu_1::srs_soar_bu as srs_soar_bu,
foreach_join_soar_bu_1::srs_dv_ds as srs_dv_ds,
foreach_join_soar_bu_1::srs_ln_ds as srs_ln_ds,
foreach_kmtsrskilvert::srs_KillVertNm as srs_KillVertNm,
foreach_join_soar_bu_1::kmt_soar_bu as kmt_soar_bu,
foreach_join_soar_bu_1::kmt_div_ds as kmt_div_ds, 
foreach_join_soar_bu_1::kmt_ln_ds as kmt_ln_ds,
foreach_kmtsrskilvert::kmt_KillVertNm as kmt_KillVertNm,
foreach_join_soar_bu_1::shc_soar_bu as shc_soar_bu,
foreach_join_soar_bu_1::TranDt as TranDt;

STORE foreach_final into '/smith/syw_member_repo/Telluride/POS_KillVert_final' using PigStorage('\\u0001');


