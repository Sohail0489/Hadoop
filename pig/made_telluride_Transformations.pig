-------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- Sears Holdings Corporation, 2014
--   
-- Name 	: TellurideTransform.pig
-- Date 	: Dec 2014
-- Author	: Vikas Tarvecha
-- Purpose 	: Take Telluride Input and generate Telluride Attributes defined in Iteration3
-- Usage	: pig -f TellurideTransform.pig
-- Note		: Only 4 inputs present in this script. SYWRMbrTel, SYWRMbrClbTel, SYWRMbrPntBal, ShcTrendMbr. 2 inputs removed, Srs/KmtSlsPtd
--
-------------------------------------------------------------------------------------------------------------------------------------------------------

-- PART 1 : Extracting Required Fields from SYWMbrTel table.
sywr_member = LOAD '$MAP_PROD_DIR/telluride/SYWRMbrTel/current' using PigStorage('\u0001') AS(CreateTs:chararray
,LyltyCardNbr1:chararray
,NmPrfx:chararray
,FirstNm:chararray
,MidNm:chararray
,LastNm:chararray
,NmSufx:chararray
,Ln1Addr:chararray
,Ln2Addr:chararray
,CityNm:chararray
,StCd:chararray
,ZipCd:chararray
,ZipCdPlus4:chararray
,CntryCd:chararray
,LangPrefCd:chararray
,PhoneNbr:chararray
,SywrOptInStsCd:chararray
,SywrDnpCd:chararray
,EmailAddr:chararray
,EmailChgDt:chararray
,EmailOptIn:chararray
,EmailOptInDt:chararray
,EmailValidRsnCd:chararray
,EmailValidRsnDt:chararray
,EmailCnfrmStatCd:chararray
,EmailCnfrmDt:chararray
,BirthDt:chararray
,EnrolRgstrDt:chararray
,EnrolSrcCd:chararray
,EnrolStrNbr:chararray
,EnrolRegNbr:chararray
,EnrolAssocId:chararray
,SywrCardType:chararray
,LyltyMbrStatCd:chararray
,LyltyMbrStatChgDt:chararray
,AssocCd:chararray
,MobilPhoneNbr:chararray
,MobilPhoneChgDt:chararray
,MobilTxtOptCd:chararray
,MobilOptInDt:chararray
,MobilValidInd:chararray
,MobilValidDt:chararray
,VipStat:chararray
,VipStatDt:chararray
,SywrNewLyltyIdNbr:chararray
,AddrChgDt:chararray
,PhoneChgDt:chararray
,NmChgDt:chararray
,SywrMbrProfIncmplInd:chararray
,SywrMbrEarnType:chararray
,SywrMbrEarnTypeDt:chararray
,SywrTestCdInd:chararray
,CreatId:chararray
,RowCrtTs:chararray
,RowModTs:chararray
,TcRqstId:chararray
,TcStrNbr:chararray
,TcAccptDt:chararray
,MbrId:chararray
,CustId:chararray
,RefClubCd:chararray
,MbrPassCd:chararray
,EnrolOfrCd:chararray
,FinlLylIdNo:chararray
,OnlineValidDt:chararray
,OnlineValidInd:chararray
,AddlNm:chararray
,SYWRDceas:chararray
,GenderCd:chararray
,LstUpdSrcCd:chararray
,LstUpdStrNbr:chararray
,LstUpdRegNbr:chararray
,LstUpdDt:chararray
,LstUpdByAssocId:chararray
,MgrtnStat:chararray
,PhoneEnrolRgstrNbr:chararray
,PhoneEnrolAssocId:chararray
,MostRcntStrType:chararray
,MostRcntStrNbr:chararray
,SrcSysInd:chararray);

A = FILTER sywr_member BY NOT( LyltyCardNbr1 == '');

sywr_member_req = FOREACH A GENERATE  LyltyCardNbr1 
,FirstNm 
,LastNm 
,EmailAddr 
,BirthDt 
,GenderCd 
,PhoneNbr 
,(CASE WHEN LyltyMbrStatCd matches 'A' THEN 'Active' ELSE 'Inactive' END) As ActiveMembership 
,(CASE 	WHEN VipStat=='S' THEN 'SILVER'
		WHEN VipStat=='P' THEN 'PLATINUM'
		WHEN VipStat == 'G' THEN 'GOLD'
		WHEN VipStat == 'E' THEN 'EXECUTIVE'
		WHEN VipStat == 'B' THEN 'BASE'
		ELSE NULL END ) AS VIPTier
,(CASE WHEN AssocCd matches 'A' THEN 'Yes' ELSE 'No' END) AS Associate 
,(CASE WHEN EmailOptIn matches 'Y' THEN 'Yes' ELSE 'No' END) As EmailOptIn 
,(CASE WHEN MobilTxtOptCd matches 'Y' THEN 'Yes' ELSE 'No' END) As PhoneOptIn 
,EnrolRgstrDt  
,EnrolSrcCd  
,EnrolStrNbr  
,MidNm  
,(CASE	WHEN LangPrefCd == 'E' THEN 'English'
	WHEN LangPrefCd == 'S' THEN 'Spanish' END) As LangPrefCd
,(YearsBetween( CurrentTime(), ToDate((CASE WHEN BirthDt is null THEN  '1900-01-01 00:00:00' ELSE BirthDt END), 'yyyy-MM-dd HH:mm:ss'))) As Age
,(StringConcat(Ln1Addr , ' ', Ln2Addr, ' ', CityNm, ' ' , StCd, ' ' , ZipCd, '-' ,ZipCdPlus4, ' ', CntryCd )) As HomeAddress
,SywrMbrEarnType
,(StringConcat(FirstNm, ' ', LastNm)) As FullName ;

-- PART 2: Extracting Required Fields from SywrMbrClbTel
sywrmbrclb = LOAD '$MAP_PROD_DIR/telluride/SywrMbrClbTel/current' using PigStorage('\u0001') AS(
CleanTs:chararray
,LyltyCardNbr2:chararray
,ClubNm:chararray
,ClubId:chararray
,ClubStat:chararray
,RowCreatUserId:chararray
,RowCreatTs:chararray
,RowModTs:chararray
,MbrAffilId:chararray
,MbrId:chararray
,ClubStatBegDt:chararray
,ClubStatEndDt:chararray
,SrcSysInd:chararray
,EnrolSrcCD:chararray
,EnrolStrNbr:chararray
,EnrolRgstrNbr:chararray
,EnrolAssocId:chararray
,EnrolOfrCd:chararray
,LastChgSrcCd:chararray
,LastChgStrNbr:chararray
,LastyRgstrNbr:chararray
,ChgRsn:chararray );

sywrmbrclbreq = FOREACH sywrmbrclb GENERATE LyltyCardNbr2, StringConcat(ClubNm,'-' ,ClubStat) as Club;
sywrmbrclubgrp = GROUP sywrmbrclbreq by LyltyCardNbr2;
sywrmbrclubtmp = FOREACH sywrmbrclubgrp GENERATE group as LyltyCardNbr2, BagToString(sywrmbrclbreq.Club) as ClubString;
sywrmbrclb_trans = FOREACH sywrmbrclubtmp GENERATE LyltyCardNbr2
,(CASE WHEN ClubString matches '.*CRAFTMAN-A.*' THEN 'Yes' ELSE 'No' END) AS CraftmanClubInd
,(CASE WHEN ClubString matches '.*KIDVANTG-A.*' THEN 'Yes' ELSE 'No' END) AS KidAdtgMbrInd
,(CASE WHEN ClubString matches '.*SYWMAX-A.*' THEN 'Yes' ELSE 'No' END) AS SywMAXMbrInd;

-- PART 3: Extract Required fields from ShcTrndMbr table
ShcTrendMbr = LOAD '$MAP_PROD_DIR/telluride/ShcTrendMbrCrm/current' using PigStorage('\u0001') AS ( CreateTs:chararray
,LyltyCardNbr3:chararray
,MthYr:chararray
,FourTripsInd:chararray
,OnlineActvInd:chararray
,RedeemInd:chararray
,SrsCCUserInd:chararray
,SYWMaxInd:chararray
,SYWRVIPInd:chararray
,TenTripsInd:chararray
,ElevenTripsInd:chararray
,TotTripsInd:chararray
,TotSls:chararray
,EmailInd:chararray
,LastShopCd:chararray
,LastRedeemCd:chararray);

ShcTrendMbr_req = FOREACH ShcTrendMbr GENERATE LyltyCardNbr3
,(CASE WHEN OnlineActvInd == '1' THEN 'Yes'
	WHEN OnlineActvInd == '0' THEN 'No' END) as OnlineActvInd
,(CASE WHEN (INT)TotTripsInd >= 1 AND (INT)TotTripsInd <= 3 THEN '1-3 Trippers'
		WHEN (INT)TotTripsInd >= 4 AND (INT)TotTripsInd <= 10 THEN '4-10 Trippers'
		WHEN (INT)TotTripsInd >= 10 THEN '10+ Trippers' END) as TripCohort
,(CASE WHEN (INT)RedeemInd == 1 THEN 'Yes' ELSE 'No' END) as RedeemDesc
,(CASE 	WHEN (INT)TotSls < 0 THEN '<0'
 	WHEN (INT)TotSls >= 0 AND (INT)TotSls <100 THEN '0-100'
        WHEN (INT)TotSls >= 100 AND (INT)TotSls <200 THEN '100-200'
        WHEN (INT)TotSls >= 200 AND (INT)TotSls <300 THEN '200-300'
        WHEN (INT)TotSls >= 300 AND (INT)TotSls <400 THEN '300-400'
        WHEN (INT)TotSls >= 400 AND (INT)TotSls <500 THEN '400-500'
        WHEN (INT)TotSls >= 500 AND (INT)TotSls <750 THEN '500-750'
        WHEN (INT)TotSls >= 750 AND (INT)TotSls <1000 THEN '750-1000'
        WHEN (INT)TotSls >= 1000 AND (INT)TotSls < 2500 THEN '1000-2500'
        WHEN (INT)TotSls >= 2500  THEN '>2500' ELSE '' END) AS TotSls
,(CASE WHEN (INT)SrsCCUserInd == 1 THEN 'Yes' ELSE 'No' END) as SrsCCUserInd
,(CASE WHEN (INT)EmailInd == 1 THEN 'Yes' ELSE 'No' END) as EmailInd;

-- PART 4: Extract Required fields from SywrMbrPntBalTel
SywrMbrPntBal = LOAD '$MAP_PROD_DIR/telluride/SywrMbrPntBalTel/current' using PigStorage('\u0001') AS(CreateTS:chararray
,LyltyCardNbr4:chararray
,LastChgDt:chararray
,SywrPtBalAmt:chararray
,TotRedeem:chararray
,PtEligEpr:chararray
,PtExpDt:chararray
,PtExpDefInd:chararray
,DatasetID:chararray
,CreatTs:chararray
,ModTs:chararray
,SpendToNxtTierLvlAmt:chararray
,TotSpendYTD:chararray
,PtdPt:chararray
,PTDVisit:chararray
,SrcSysInd:chararray);

SywrMbrPntBal_req = FOREACH SywrMbrPntBal GENERATE LyltyCardNbr4
,SywrPtBalAmt
,SpendToNxtTierLvlAmt;

-- PART 5: JOINS

Output1 = JOIN sywr_member_req by LyltyCardNbr1 LEFT OUTER, sywrmbrclb_trans by LyltyCardNbr2;
Output2 = JOIN Output1 by sywr_member_req::LyltyCardNbr1 LEFT OUTER, ShcTrendMbr_req by LyltyCardNbr3;
Output3 = JOIN Output2 by sywr_member_req::LyltyCardNbr1 LEFT OUTER, SywrMbrPntBal_req by LyltyCardNbr4;

-- PART 6: FINAL SCHEMA GENERATION
TellurideOutput = FOREACH Output3 GENERATE Output2::Output1::sywr_member_req::LyltyCardNbr1
,Output2::Output1::sywr_member_req::FirstNm
,Output2::Output1::sywr_member_req::LastNm
,Output2::Output1::sywr_member_req::EmailAddr
,Output2::Output1::sywr_member_req::BirthDt
,Output2::Output1::sywr_member_req::GenderCd
,Output2::Output1::sywr_member_req::PhoneNbr
,Output2::Output1::sywr_member_req::ActiveMembership
,Output2::Output1::sywr_member_req::VIPTier
,Output2::Output1::sywr_member_req::Associate
,Output2::Output1::sywr_member_req::EmailOptIn
,Output2::Output1::sywr_member_req::PhoneOptIn
,Output2::Output1::sywr_member_req::EnrolRgstrDt
,Output2::Output1::sywr_member_req::EnrolSrcCd
,Output2::Output1::sywr_member_req::EnrolStrNbr
,Output2::Output1::sywr_member_req::MidNm
,Output2::Output1::sywr_member_req::LangPrefCd
,Output2::Output1::sywr_member_req::Age
,Output2::Output1::sywr_member_req::HomeAddress
,Output2::Output1::sywr_member_req::SywrMbrEarnType
,Output2::Output1::sywr_member_req::FullName
,Output2::Output1::sywrmbrclb_trans::CraftmanClubInd
,Output2::Output1::sywrmbrclb_trans::KidAdtgMbrInd
,Output2::Output1::sywrmbrclb_trans::SywMAXMbrInd
,Output2::ShcTrendMbr_req::OnlineActvInd
,Output2::ShcTrendMbr_req::TripCohort
,Output2::ShcTrendMbr_req::RedeemDesc
,SywrMbrPntBal_req::SywrPtBalAmt
,SywrMbrPntBal_req::SpendToNxtTierLvlAmt
,''
,''
,Output2::ShcTrendMbr_req::TotSls
,''
,Output2::ShcTrendMbr_req::SrsCCUserInd
,Output2::ShcTrendMbr_req::EmailInd;

STORE TellurideOutput INTO '$MADE_WORK_DIR/telluride/telluride_transformed' using PigStorage('\u0001');
