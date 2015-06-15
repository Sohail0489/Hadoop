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



SrsSlsPtdReq = FILTER SrsSlsPtd BY FacilSbtCd IN ('A','B','C','D','G1','G2','N1','N2','N4','M') AND DivNbr !='0' AND DivNbr !='79';
srs_year = FILTER SrsSlsPtdReq BY ToDate(TranDt,'yyyy-MM-dd')>= ToDate('2013-12-01','yyyy-MM-dd')AND ToDate(TranDt,'yyyy-MM-dd')<= ToDate('2014-12-01','yyyy-MM-dd') AND (LyltyCardNbr IS NOT NULL);
kmt_year = FILTER KmtSlsPtd BY ToDate(TranDt,'yyyy-MM-dd')>= ToDate('2013-12-01','yyyy-MM-dd')AND ToDate(TranDt,'yyyy-MM-dd')<= ToDate('2014-12-01','yyyy-MM-dd') AND (LyltyCardNbr IS NOT NULL); 
float_SlsSrs_yr = FOREACH srs_year GENERATE TranDt,(FLOAT)NetMerchSls,DivNbr,ItemNbr,LyltyCardNbr;
joinSlsSrs_year = JOIN float_SlsSrs_yr BY (DivNbr,ItemNbr), srs_soar_bu BY (div_no,itm_no);

groupSlsSrs_year = GROUP joinSlsSrs_year 	
BY (srs_soar_bu::soar_no, srs_soar_bu::soar_nm,float_SlsSrs_yr::LyltyCardNbr);

TotalSlsSrs_year = FOREACH groupSlsSrs_year GENERATE group,ROUND(SUM(joinSlsSrs_year.float_SlsSrs_yr::NetMerchSls)*100)/100.0f as total_srs_sales; 



--KMT

float_SlsKmt_yr = FOREACH kmt_year GENERATE TranDt,(FLOAT)KmtSell-(FLOAT)MrkdnAmt  as NetMerchSls,KsnId,LyltyCardNbr;
joinSlsKmt_year = JOIN float_SlsKmt_yr BY KsnId, Kmt_Soar_Bu BY KSN_ID;
groupSlsKmt_year = GROUP joinSlsKmt_year 	
BY (Kmt_Soar_Bu::SOAR_NO, Kmt_Soar_Bu::SOAR_NM,float_SlsKmt_yr::LyltyCardNbr);
TotalSlsKmt_year = FOREACH groupSlsKmt_year GENERATE group, ROUND(SUM(joinSlsKmt_year.float_SlsKmt_yr::NetMerchSls)*100)/100.0f as total_kmt_sales
;


--TOTAL SHC SALES


joinshcsrs_sales = JOIN joinSlsSrs_year BY srs_soar_bu::soar_no, ShcSoarBu BY SrsSoarNbr;
groupshcsrs = GROUP joinshcsrs_sales BY (ShcSoarBu::ShcSoarNbr,ShcSoarBu::ShcSoarNm,joinSlsSrs_year::float_SlsSrs_yr::LyltyCardNbr);

joinshckmt_sales = JOIN joinSlsKmt_year BY Kmt_Soar_Bu::SOAR_NO, ShcSoarBu BY KmtSoarNbr;
groupshckmt = GROUP joinshckmt_sales BY (ShcSoarBu::ShcSoarNbr,ShcSoarBu::ShcSoarNm,joinSlsKmt_year::float_SlsKmt_yr::LyltyCardNbr);

foreachshcsrs_sales = FOREACH groupshcsrs GENERATE group,ROUND(SUM(joinshcsrs_sales.joinSlsSrs_year::float_SlsSrs_yr::NetMerchSls)*100)/100.0f as sales;

foreachshckmt_sales = FOREACH groupshckmt GENERATE group, ROUND(SUM(joinshckmt_sales.joinSlsKmt_year::float_SlsKmt_yr::NetMerchSls)*100)/100.0f as sales;
	
union_SHC_Sales = UNION foreachshcsrs_sales, foreachshckmt_sales;
group_SHC_Sales = GROUP union_SHC_Sales by group;
Total_SHC_Sales = FOREACH group_SHC_Sales GENERATE group, ROUND(SUM(union_SHC_Sales.sales)*100)/100.0f as total_shc_sales;
	

--TRIP COUNT

TotalTripSrs_year = FOREACH groupSlsSrs_year  {
a = DISTINCT joinSlsSrs_year.float_SlsSrs_yr::TranDt;
GENERATE group, COUNT(a) as Srs_Trip_Count;};


TotalTripKmt_year = FOREACH groupSlsKmt_year  {
a = DISTINCT joinSlsKmt_year.float_SlsKmt_yr::TranDt;
GENERATE group, COUNT(a) as Kmt_Trip_Count;};


--TOTAL SHC TRIPCOUNT

foreachshcsrs_trip = FOREACH groupshcsrs GENERATE FLATTEN(group),FLATTEN(joinshcsrs_sales.joinSlsSrs_year::float_SlsSrs_yr::TranDt) as tran_date;
foreachshckmt_trip = FOREACH groupshckmt GENERATE FLATTEN(group), FLATTEN(joinshckmt_sales.joinSlsKmt_year::float_SlsKmt_yr::TranDt) as tran_date;

unionSHC_Trip = UNION foreachshcsrs_trip, foreachshckmt_trip;
groupSHC_Trip = GROUP unionSHC_Trip BY 
(group::ShcSoarBu::ShcSoarNbr,group::ShcSoarBu::ShcSoarNm,group::joinSlsSrs_year::float_SlsSrs_yr::LyltyCardNbr);

TotalTripSHC= FOREACH groupSHC_Trip{
A = DISTINCT unionSHC_Trip.tran_date;
GENERATE group, COUNT(A)as Shc_Trip_Count;};

------------------------------------------------------------------------------------------------------------------------------------
-- creating a table having all the combinations of shc_no,shc_nm,srs_no.kmt_no by join srssoarbu,kmtsoarbu,shcsoarbu tables----------- 


join_shc_srs = JOIN ShcSoarBu BY SrsSoarNbr, srs_soar_bu BY soar_no;
foreach_join_shc_srs_1 = FOREACH join_shc_srs GENERATE 
$1 as shc_no, $2 as shc_nm, $3 as srs_no, $4 as kmt_no;
foreach_join_shc_srs = DISTINCT foreach_join_shc_srs_1;
join_shc_kmt = JOIN ShcSoarBu BY KmtSoarNbr, Kmt_Soar_Bu BY SOAR_NO;
foreach_join_shc_kmt_1 = FOREACH join_shc_kmt GENERATE 
$1 as shc_no, $2 as shc_nm, $3 as srs_no, $4 as kmt_no, Kmt_Soar_Bu::SOAR_NM as kmt_nm;
foreach_join_shc_kmt = DISTINCT foreach_join_shc_kmt_1;
join_join_shc_kmt= join foreach_join_shc_kmt BY shc_no FULL, foreach_join_shc_srs BY shc_no;
foreach_join_shcsrskmt = FOREACH join_join_shc_kmt GENERATE
(CASE WHEN (foreach_join_shc_kmt::shc_no) IS NULL THEN foreach_join_shc_srs::shc_no ELSE foreach_join_shc_kmt::shc_no END) as shc_no,
(CASE WHEN (foreach_join_shc_kmt::shc_nm) IS NULL THEN foreach_join_shc_srs::shc_nm ELSE foreach_join_shc_kmt::shc_nm END) as shc_nm,
(CASE WHEN (foreach_join_shc_kmt::srs_no) IS NULL THEN foreach_join_shc_srs::srs_no ELSE foreach_join_shc_kmt::srs_no END) as srs_no,
(CASE WHEN (foreach_join_shc_kmt::kmt_no) IS NULL THEN foreach_join_shc_srs::kmt_no ELSE foreach_join_shc_kmt::kmt_no END) as kmt_no;
----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------
--merging sales
-----------------------------

join_srs_shc = JOIN TotalSlsSrs_year BY group.srs_soar_bu::soar_no,
foreach_join_shcsrskmt BY srs_no;

foreach_srs_shc = FOREACH join_srs_shc GENERATE FLATTEN(TotalSlsSrs_year::group),
foreach_join_shcsrskmt::shc_no as shc_no, foreach_join_shcsrskmt::kmt_no as kmt_no,
TotalSlsSrs_year::total_srs_sales as total_srs_sales;

foreach_srs_shc_1 = FOREACH foreach_srs_shc  GENERATE 
$0 as srs_no,$1 as srs_nm, $2 as lyltyCardNbr, $3 as shc_no, $4 as kmt_no, $5 as total_srs_sales;

join_kmt_shc = JOIN TotalSlsKmt_year BY group.Kmt_Soar_Bu::SOAR_NO,
foreach_join_shcsrskmt BY kmt_no;

foreach_kmt_shc = FOREACH join_kmt_shc GENERATE FLATTEN(TotalSlsKmt_year::group),
foreach_join_shcsrskmt::shc_no as shc_no, foreach_join_shcsrskmt::srs_no as srs_no,
TotalSlsKmt_year::total_kmt_sales as total_kmt_sales;

foreach_kmt_shc_1 = FOREACH foreach_kmt_shc  GENERATE 
$0 as kmt_no,$1 as kmt_nm, $2 as lyltyCardNbr, $3 as shc_no, $4 as srs_no, $5 as total_kmt_sales;


join_srs_kmt = JOIN foreach_srs_shc_1 BY (shc_no,lyltyCardNbr) FULL,
foreach_kmt_shc_1 BY (shc_no,lyltyCardNbr);


foreach_join_srs_kmt = FOREACH join_srs_kmt GENERATE
(CASE WHEN (foreach_srs_shc_1::lyltyCardNbr) IS NULL THEN foreach_kmt_shc_1::lyltyCardNbr ELSE foreach_srs_shc_1::lyltyCardNbr END) as LyltyCardNbr,
(CASE WHEN (foreach_srs_shc_1::shc_no) IS NULL THEN foreach_kmt_shc_1::shc_no ELSE foreach_srs_shc_1::shc_no END) as shc_no,
foreach_srs_shc_1::srs_nm as srs_nm,
foreach_kmt_shc_1::kmt_nm as kmt_nm,
foreach_srs_shc_1::total_srs_sales as total_srs_sales,
foreach_kmt_shc_1::total_kmt_sales as total_kmt_sales;


Joinshc_srs_kmt = JOIN Total_SHC_Sales BY (group.ShcSoarBu::ShcSoarNbr, group.joinSlsSrs_year::float_SlsSrs_yr::LyltyCardNbr),
foreach_join_srs_kmt BY (shc_no,LyltyCardNbr);

Foreachshc_srs_kmt = FOREACH Joinshc_srs_kmt GENERATE
foreach_join_srs_kmt::LyltyCardNbr as LyltyCardNbr,
foreach_join_srs_kmt::srs_nm as srs_nm,
foreach_join_srs_kmt::total_srs_sales as total_srs_sales,
foreach_join_srs_kmt::kmt_nm as kmt_nm,
foreach_join_srs_kmt::total_kmt_sales as total_kmt_sales,
foreach_join_srs_kmt::shc_no as shc_no,
Total_SHC_Sales::group.ShcSoarBu::ShcSoarNm as shc_nm, Total_SHC_Sales::total_shc_sales as total_shc_sales;

------------------------------------------------------------------------------------------------------------------
--merging tipcounts
-------------------------------------------------------------------------------------------------------------------

join_srs_shc_trip = JOIN TotalTripSrs_year BY group.srs_soar_bu::soar_no,
foreach_join_shcsrskmt BY srs_no;

foreach_srs_shc_trip = FOREACH join_srs_shc_trip GENERATE FLATTEN(TotalTripSrs_year::group),
foreach_join_shcsrskmt::shc_no as shc_no, foreach_join_shcsrskmt::kmt_no as kmt_no,
TotalTripSrs_year::Srs_Trip_Count as total_srs_trips;

foreach_srs_shc_trip_1 = FOREACH foreach_srs_shc_trip  GENERATE 
$0 as srs_no,$1 as srs_nm, $2 as lyltyCardNbr, $3 as shc_no, $4 as kmt_no, $5 as total_srs_trips;

join_kmt_shc_trip = JOIN TotalTripKmt_year BY group.Kmt_Soar_Bu::SOAR_NO,
foreach_join_shcsrskmt BY kmt_no;

foreach_kmt_shc_trip = FOREACH join_kmt_shc_trip GENERATE FLATTEN(TotalTripKmt_year::group),
foreach_join_shcsrskmt::shc_no as shc_no, foreach_join_shcsrskmt::srs_no as srs_no,
TotalTripKmt_year::Kmt_Trip_Count as total_kmt_trips;

foreach_kmt_shc_trip_1 = FOREACH foreach_kmt_shc_trip  GENERATE 
$0 as kmt_no,$1 as kmt_nm, $2 as lyltyCardNbr, $3 as shc_no, $4 as srs_no, $5 as total_kmt_trips;


join_srs_kmt_trip = JOIN foreach_srs_shc_trip_1 BY (shc_no,lyltyCardNbr) FULL,
foreach_kmt_shc_trip_1 BY (shc_no,lyltyCardNbr);


foreach_join_srs_kmt_trip = FOREACH join_srs_kmt_trip GENERATE
(CASE WHEN (foreach_srs_shc_trip_1::lyltyCardNbr) IS NULL THEN foreach_kmt_shc_trip_1::lyltyCardNbr ELSE foreach_srs_shc_trip_1::lyltyCardNbr END) as LyltyCardNbr,
(CASE WHEN (foreach_srs_shc_trip_1::shc_no) IS NULL THEN foreach_kmt_shc_trip_1::shc_no ELSE foreach_srs_shc_trip_1::shc_no END) as shc_no,
foreach_srs_shc_trip_1::srs_nm as srs_nm,
foreach_kmt_shc_trip_1::kmt_nm as kmt_nm,
foreach_srs_shc_trip_1::total_srs_trips as total_srs_trips,
foreach_kmt_shc_trip_1::total_kmt_trips as total_kmt_trips;


Joinshc_srs_kmt_trip = JOIN TotalTripSHC BY (group.ShcSoarBu::ShcSoarNbr,group.group::joinSlsSrs_year::float_SlsSrs_yr::LyltyCardNbr),
foreach_join_srs_kmt_trip BY (shc_no,LyltyCardNbr);


Foreachshc_srs_kmt_trip = FOREACH Joinshc_srs_kmt_trip GENERATE
foreach_join_srs_kmt_trip::LyltyCardNbr as LyltyCardNbr,
foreach_join_srs_kmt_trip::srs_nm as srs_nm,
foreach_join_srs_kmt_trip::total_srs_trips as total_srs_trips,
foreach_join_srs_kmt_trip::kmt_nm as kmt_nm,
foreach_join_srs_kmt_trip::total_kmt_trips as total_kmt_trips,
foreach_join_srs_kmt_trip::shc_no as shc_no,
TotalTripSHC::group.ShcSoarBu::ShcSoarNm as shc_nm, TotalTripSHC::Shc_Trip_Count as total_shc_trips;
------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--merging all atributes

Final_all_attrib_join = JOIN Foreachshc_srs_kmt BY (LyltyCardNbr,shc_no), Foreachshc_srs_kmt_trip BY (LyltyCardNbr,shc_no);


Final_all_attrib = FOREACH Final_all_attrib_join GENERATE
$0 as LyltyCardNbr,
$1 as srs_nm,
$2 as total_srs_sales,
$10 as total_srs_trips,
$3 as kmt_nm,
$4 as total_kmt_sales,
$12 as total_kmt_trips,
$6 as shc_nm,
$7 as total_shc_sales,
$15 as total_Shc_tripcount;


STORE Final_all_attrib into '/smith/syw_member_repo/Telluride/POS_Detailed' using PigStorage('\t');
