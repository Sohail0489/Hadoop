--------------------------------------------------------------------------------------------------------
-- Sears Holding Corporation, 2015
-- Script	: Pos_6Attr_v2.pig
-- Purpose	: Transform POS attributes for load into golden collection 
--         
--               Version Detail
--   Author	Version		Detail
--   Sohail       1.0           Transform POS, Killer Vertical and Soar BU tables and create single
--				POS HDFS file for load into collection
--   Vikas        2.0		Adding Primary Store and TOP 1000 Ranks and flags for Primary Stores
--------------------------------------------------------------------------------------------------------
REGISTER '/home/auto/ldeshpa/MAP_HADOOP/jar/pig_concat.jar';
register /home/auto/vtarvec/datafu-1.1.0.jar;
define Enumerate datafu.pig.bags.Enumerate('1');


srs_soar_bu = LOAD '/work/syw_member_repo/Telluride/rd_srs_soar_bu_1' using PigStorage('\u0001') AS(
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

Kmt_Soar_Bu = LOAD '/work/syw_member_repo/Telluride/Rd_Kmt_Soar_Bu_1' using PigStorage('\u0001') AS(
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

SrsSlsPtd = LOAD '/user/smoham3/test_scripts/srsslsptd_test' using PigStorage('\u0001') AS(
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

KmtSlsPtd = LOAD '/user/smoham3/test_scripts/kmtslsptd_test' using PigStorage('\u0001') AS(CreateTs:chararray
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
 
 ---- Sears
SrsSlsPtdReq = FILTER SrsSlsPtd BY FacilSbtCd IN ('A','B','C','D','G1','G2','N1','N2','N4','M') AND DivNbr !='0' AND DivNbr !='79';

srs_year = FILTER SrsSlsPtdReq BY (LONG)YearsBetween(CurrentTime(),ToDate(TranDt,'yyyy-MM-dd'))<=1 AND (LyltyCardNbr IS NOT NULL);

float_SlsSrs_yr = FOREACH srs_year GENERATE DivNbr,ItemNbr,LyltyCardNbr,TranDt,(FLOAT)NetMerchSls;

joinSlsSrs_year = JOIN float_SlsSrs_yr BY (DivNbr,ItemNbr), srs_soar_bu BY (div_no,itm_no);

foreach_SlsSrs_year = FOREACH joinSlsSrs_year{
A = CONCAT(srs_soar_bu::soar_nm,CONCAT('||',srs_soar_bu::div_nm));
GENERATE 
float_SlsSrs_yr::LyltyCardNbr as LyltyCardNbr,
srs_soar_bu::soar_nm as soar_nm,
A as div_ds,
CONCAT(A,CONCAT('||',srs_soar_bu::ln_ds)) as ln_ds,
float_SlsSrs_yr::NetMerchSls as SrsTotSls,
float_SlsSrs_yr::TranDt as TranDt;};

groupSlsSrs_year = GROUP foreach_SlsSrs_year BY LyltyCardNbr;

SrsSoar_nm = FOREACH groupSlsSrs_year {
Visits = DISTINCT foreach_SlsSrs_year.TranDt;
GENERATE
group as LyltyCardNbr, 
org.sears.concat.Concat_Tuple(foreach_SlsSrs_year.soar_nm) as srs_soar_bu,
org.sears.concat.Concat_Tuple(foreach_SlsSrs_year.div_ds) as srs_div_nm,
org.sears.concat.Concat_Tuple(foreach_SlsSrs_year.ln_ds) as srs_ln_ds,
SUM(foreach_SlsSrs_year.SrsTotSls) as SrsTotSls,
COUNT(Visits) as SrsTripCnt;};

----Sears Killer Vertical
srs_killver = join float_SlsSrs_yr BY (DivNbr,ItemNbr), 
KillVertSrs BY (DivNbr,ItemNbr);

groupsrskill = GROUP srs_killver BY float_SlsSrs_yr::LyltyCardNbr;

srs_killVert_year = FOREACH groupsrskill
GENERATE 
group as LyltyCardNbr,
org.sears.concat.Concat_Tuple(srs_killver.KillVertSrs::KillVertNm) as KillVertNm;

--KMART
kmt_year = FILTER KmtSlsPtd BY (LONG)YearsBetween(CurrentTime(),ToDate(TranDt,'yyyy-MM-dd'))<=1 AND (LyltyCardNbr IS NOT NULL);

float_SlsKmt_yr = FOREACH kmt_year GENERATE KsnId,LyltyCardNbr,TranDt,((FLOAT) KmtSell -(FLOAT)MrkdnAmt) as KmtTotSls;

joinSlsKmt_year = JOIN float_SlsKmt_yr BY KsnId, Kmt_Soar_Bu BY KSN_ID;

foreach_joinSlsKmt_year = FOREACH joinSlsKmt_year GENERATE
float_SlsKmt_yr::LyltyCardNbr as LyltyCardNbr,
Kmt_Soar_Bu::FP_DVSN_DESC as FP_DVSN_DESC,
Kmt_Soar_Bu::FP_DEPT_NBR as FP_DEPT_NBR,
Kmt_Soar_Bu::FP_CATG_GRP_DESC as FP_CATG_GRP_DESC,
Kmt_Soar_Bu::SOAR_NM as SOAR_NM,
float_SlsKmt_yr::KmtTotSls as KmtTotSls,
float_SlsKmt_yr::TranDt as TranDt;

----table for distinct FP_CATG_GRP_DESC and min FP_DEPT_NBR--
group_CATG_DEPT = GROUP Kmt_Soar_Bu BY FP_CATG_GRP_DESC;

foreach_CATG_DEPT = FOREACH group_CATG_DEPT GENERATE
group as FP_CATG_GRP_DESC,CONCAT(MIN(Kmt_Soar_Bu.FP_DEPT_NBR),CONCAT(' ',group))as FP_DEPT_NBR_CATG; 

-------------------------------------------------------------------
join_KmtSoar_CATG_DEPT = join foreach_joinSlsKmt_year BY FP_CATG_GRP_DESC, foreach_CATG_DEPT  BY FP_CATG_GRP_DESC;

foreach_KmtSoar_CATG_DEPT = FOREACH join_KmtSoar_CATG_DEPT	 {
A = StringConcat(foreach_joinSlsKmt_year::SOAR_NM,'||',foreach_joinSlsKmt_year::FP_DVSN_DESC);
GENERATE
foreach_joinSlsKmt_year::LyltyCardNbr as LyltyCardNbr,
A as FP_DVSN_DESC,
foreach_joinSlsKmt_year::SOAR_NM as SOAR_NM,
StringConcat(A, '||',foreach_CATG_DEPT::FP_DEPT_NBR_CATG) as FP_DEPT_NBR_CATG,
foreach_joinSlsKmt_year::KmtTotSls as KmtTotSls,
foreach_joinSlsKmt_year::TranDt as TranDt;};

groupSlsKmt_year = GROUP foreach_KmtSoar_CATG_DEPT
BY LyltyCardNbr;

KmtSoar_nm = FOREACH groupSlsKmt_year {
A = DISTINCT foreach_KmtSoar_CATG_DEPT.SOAR_NM;
B = DISTINCT foreach_KmtSoar_CATG_DEPT.FP_DEPT_NBR_CATG;
C = DISTINCT foreach_KmtSoar_CATG_DEPT.FP_DVSN_DESC;
Visits = DISTINCT foreach_KmtSoar_CATG_DEPT.TranDt;
GENERATE
group as LyltyCardNbr, 
org.sears.concat.Concat_Tuple(A) as kmt_soarbu_nm,
org.sears.concat.Concat_Tuple(C) as kmt_div_desc,
org.sears.concat.Concat_Tuple(B) as kmt_line_desc,
SUM(foreach_KmtSoar_CATG_DEPT.KmtTotSls) as KmtTotSls,
COUNT(Visits) as KmtTripCnt;};

--KMART Killer Vertical
kmt_killver = join float_SlsKmt_yr BY KsnId,
KillVertKmt BY KsnId;

groupkmtkill = GROUP kmt_killver BY float_SlsKmt_yr::LyltyCardNbr;

kmt_killVert_year = FOREACH groupkmtkill
GENERATE 
group as LyltyCardNbr,
org.sears.concat.Concat_Tuple(kmt_killver.KillVertKmt::KillVertNm) as KillVertNm;

------JOIN Kmart & Sears killVertNm
join_kmtsrsKillVert = join srs_killVert_year by LyltyCardNbr FULL, kmt_killVert_year by LyltyCardNbr;

foreach_kmtsrskilvert = FOREACH join_kmtsrsKillVert GENERATE
(CASE WHEN srs_killVert_year::LyltyCardNbr IS NULL THEN kmt_killVert_year::LyltyCardNbr ELSE srs_killVert_year::LyltyCardNbr END) as LyltyCardNbr,
srs_killVert_year::KillVertNm as srs_KillVertNm,
kmt_killVert_year::KillVertNm as kmt_KillVertNm;

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
--Srs Soar Name and Kmt Soar Name
join_soar_bu = JOIN SrsSoar_nm BY LyltyCardNbr FULL, KmtSoar_nm BY LyltyCardNbr;

foreach_join_soar_bu = FOREACH join_soar_bu GENERATE 
(CASE WHEN (SrsSoar_nm::LyltyCardNbr) IS NULL THEN KmtSoar_nm::LyltyCardNbr ELSE SrsSoar_nm::LyltyCardNbr END)as LyltyCardNbr, 
SrsSoar_nm::srs_soar_bu as srs_soar_bu,
SrsSoar_nm::srs_div_nm as srs_dv_ds,
SrsSoar_nm::srs_ln_ds as srs_ln_ds,
KmtSoar_nm::kmt_soarbu_nm as kmt_soar_bu,
KmtSoar_nm::kmt_div_desc as kmt_div_ds,
KmtSoar_nm::kmt_line_desc as kmt_ln_ds,
SrsSoar_nm::SrsTotSls as SrsTotSls,
SrsSoar_nm::SrsTripCnt as SrsTripCnt,
KmtSoar_nm::KmtTotSls as KmtTotSls,
KmtSoar_nm::KmtTripCnt as KmtTripCnt;

-- Srs/Kmt Soar BU + SHC Sales Tables
join_soar_bu_1 = JOIN foreach_join_soar_bu BY LyltyCardNbr FULL, foreach_group_unionshc_soar BY LyltyCardNbr;

foreach_join_soar_bu_1 = FOREACH join_soar_bu_1 GENERATE (CASE WHEN foreach_join_soar_bu::LyltyCardNbr IS NULL THEN foreach_group_unionshc_soar::LyltyCardNbr ELSE foreach_join_soar_bu::LyltyCardNbr END) as LyltyCardNbr, 
foreach_join_soar_bu::srs_soar_bu as srs_soar_bu,
foreach_join_soar_bu::srs_dv_ds as srs_dv_ds,
foreach_join_soar_bu::srs_ln_ds as srs_ln_ds,
foreach_join_soar_bu::kmt_soar_bu as kmt_soar_bu,
foreach_join_soar_bu::kmt_div_ds as kmt_div_ds,
foreach_join_soar_bu::kmt_ln_ds as kmt_ln_ds,
foreach_group_unionshc_soar::ShcSoarNm as shc_soar_bu,
foreach_group_unionshc_soar::TranDt as TranDt,
foreach_join_soar_bu::SrsTotSls as SrsTotSls,
foreach_join_soar_bu::SrsTripCnt as SrsTripCnt,
foreach_join_soar_bu::KmtTotSls as KmtTotSls,
foreach_join_soar_bu::KmtTripCnt as KmtTripCnt;

-- Srs/Kmt Soar BU + SHC Sales + Killer Vertical
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
foreach_join_soar_bu_1::TranDt as TranDt,
foreach_join_soar_bu_1::SrsTotSls as SrsTotSls,
foreach_join_soar_bu_1::SrsTripCnt as SrsTripCnt,
foreach_join_soar_bu_1::KmtTotSls as KmtTotSls,
foreach_join_soar_bu_1::KmtTripCnt as KmtTripCnt;

-- Primary Store
sywprimarystore = LOAD '/smith/map/sywr_primary_store_new' using PigStorage('\u0001') AS (datacreationts:chararray,
lyltycardnbr :chararray,
flsrfmstore:chararray,
flsrfmdistance:chararray,
flscloseststore:chararray,
flsclosestdistance:chararray,
flsprimarystore:chararray,
flsprimarydistance:chararray,
sacrfmstore:chararray,
sacrfmdistance:chararray,
saccloseststore:chararray,
sacclosestdistance:chararray,
sacprimarystore:chararray,
sacprimarydistance:chararray,
kmtrfmstore :chararray,
kmtrfmdistance:chararray,
kmtcloseststore :chararray,
kmtclosestdistance:chararray,
kmtprimarystore :chararray,
kmtprimarydistance:chararray);

sywprimarystore_req = FOREACH sywprimarystore GENERATE lyltycardnbr
,(INT) (SUBSTRING(flsrfmstore, 4, 7)) AS flsrfmstore
,(INT) (SUBSTRING(kmtrfmstore, 4, 7)) AS kmtrfmstore
,(INT) flsprimarystore 
,(INT) kmtprimarystore;

ShcLocn = LOAD '/work/syw_member_repo/Inferred_Internal/ShcLocn' using PigStorage('\u0001') AS (createTs:chararray
,LocnNbr:chararray
,StrFmt:chararray
,RgnNbr:chararray
,DistNbr:chararray
,LocnCity:chararray
,LocnStCd:chararray
,ZipCd:chararray
,ZipPls4:chararray
,NatlNbr:chararray
,NatlDesc:chararray
,LocnNm:chararray
,VpRgnNm:chararray
,RgnMgrNm:chararray
,CloseDt:chararray
,PlanCloseDt:chararray
,OpenDt:chararray
,DmMgrNm:chararray
,FmtType:chararray
,StrFmtDesc:chararray
,DmaNm:chararray
,Lat:chararray
,Longtd:chararray
,OrigFacilNbr:chararray
,LocnStat:chararray
,RowCreatTs:chararray
,RowCreatUserId:chararray
,RowModTs:chararray
,RowModUserId:chararray);

ShcLocn_Req = FOREACH ShcLocn GENERATE LocnNm
,(INT)LocnNbr
,(INT)OrigFacilNbr
,LocnStat;

ShcLocn_Open = FILTER ShcLocn_Req BY (LocnStat != 'CLOSED');

PrimaryStoreSearsJoin = JOIN sywprimarystore_req BY flsrfmstore LEFT OUTER, ShcLocn_Open BY OrigFacilNbr;
PrimaryStoreKmartJoin = JOIN sywprimarystore_req BY kmtrfmstore LEFT OUTER, ShcLocn_Open BY LocnNbr;

PrimaryStoreSears = FOREACH PrimaryStoreSearsJoin GENERATE sywprimarystore_req::lyltycardnbr as lyltycardnbr
,StringConcat(ShcLocn_Open::OrigFacilNbr, '-', ShcLocn_Open::LocnNm) as srs_primary_store;


PrimaryStoreKmart = FOREACH PrimaryStoreKmartJoin GENERATE sywprimarystore_req::lyltycardnbr as lyltycardnbr
,StringConcat(ShcLocn_Open::LocnNbr, '-', ShcLocn_Open::LocnNm) as kmt_primary_store;

join_srs_kmt_store = JOIN PrimaryStoreSears BY lyltycardnbr, PrimaryStoreKmart BY lyltycardnbr;

foreach_srs_kmt_store = FOREACH join_srs_kmt_store GENERATE
PrimaryStoreSears::lyltycardnbr as lyltycardnbr, 
PrimaryStoreSears::srs_primary_store as srs_primary_store,
PrimaryStoreKmart::kmt_primary_store as kmt_primary_store;

---- JOIN POS with Primary Store 

POS_final_JOIN = JOIN foreach_final BY LyltyCardNbr LEFT OUTER,  foreach_srs_kmt_store  BY lyltycardnbr;

POS_final = FOREACH POS_final_JOIN GENERATE foreach_final::LyltyCardNbr,
foreach_final::srs_soar_bu as srs_soar_bu,
foreach_final::srs_dv_ds as srs_dv_ds,
foreach_final::srs_ln_ds as srs_ln_ds,
foreach_final::srs_KillVertNm as srs_KillVertNm,
foreach_final::kmt_soar_bu as kmt_soar_bu,
foreach_final::kmt_div_ds as kmt_div_ds, 
foreach_final::kmt_ln_ds as kmt_ln_ds,
foreach_final::kmt_KillVertNm as kmt_KillVertNm,
foreach_final::shc_soar_bu as shc_soar_bu,
foreach_final::TranDt as TranDt,
(float)foreach_final::SrsTotSls as SrsTotSls,
(int)foreach_final::SrsTripCnt as SrsTripCnt,
(float)foreach_final::KmtTotSls as KmtTotSls,
(int)foreach_final::KmtTripCnt as KmtTripCnt,
foreach_srs_kmt_store::srs_primary_store as srs_primary_store,
foreach_srs_kmt_store::kmt_primary_store as kmt_primary_store;

---- Sears Ranking and Flag
POS_Srs_group = GROUP POS_final BY srs_primary_store;

POS_Srs_sls_sort = FOREACH POS_Srs_group {
				sorted = ORDER POS_final BY SrsTotSls DESC, SrsTripCnt DESC;
				GENERATE group,
				sorted;
				};
POS_Srs_rank_enum = FOREACH POS_Srs_sls_sort GENERATE FLATTEN(Enumerate(sorted));

POS_Srs_rank_final = FOREACH POS_Srs_rank_enum GENERATE LyltyCardNbr,
srs_soar_bu,
srs_dv_ds,
srs_ln_ds,
srs_KillVertNm,
kmt_soar_bu,
kmt_div_ds, 
kmt_ln_ds,
kmt_KillVertNm,
shc_soar_bu,
TranDt,
SrsTotSls,
SrsTripCnt,
KmtTotSls,
KmtTripCnt,
srs_primary_store,
kmt_primary_store,
i as Srs_rank;

-- KMART Ranking and Flag
POS_Kmt_group = GROUP POS_Srs_rank_final BY kmt_primary_store;

POS_Kmt_sls_sort = FOREACH POS_Kmt_group {
				sorted = ORDER POS_Srs_rank_final BY KmtTotSls DESC, KmtTripCnt DESC;
				GENERATE group,
				sorted;
				};
POS_Kmt_rank_enum = FOREACH POS_Kmt_sls_sort GENERATE FLATTEN(Enumerate(sorted));

POS_Kmt_rank_final = FOREACH POS_Kmt_rank_enum GENERATE LyltyCardNbr,
srs_soar_bu,
srs_dv_ds,
srs_ln_ds,
srs_KillVertNm,
kmt_soar_bu,
kmt_div_ds, 
kmt_ln_ds,
kmt_KillVertNm,
shc_soar_bu,
TranDt,
SrsTotSls,
SrsTripCnt,
KmtTotSls,
KmtTripCnt,
srs_primary_store,
kmt_primary_store,
(CASE WHEN srs_primary_store IS NOT NULL THEN Srs_rank END) as Srs_rank,
(CASE WHEN kmt_primary_store IS NOT NULL THEN i END)  as Kmt_rank,
(CASE WHEN srs_primary_store IS NOT NULL AND Srs_rank <= 1000 THEN 'Y' END) as Srs_Top_1000_Flag,
(CASE WHEN kmt_primary_store IS NOT NULL AND i <= 1000 THEN 'Y' END) as Kmt_Top_1000_Flag;

STORE POS_Kmt_rank_final INTO '/user/smoham3/POS_KillVert_Rank_final_date' using PigStorage('\u0001');

