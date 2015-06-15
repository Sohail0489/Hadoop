/*****************************************************************************************************************
Script Name: CDI_Transformations.pig
Author: Srujan Dussa & Vignesh Sithannan
Create Date: 01/06/2015
Modified Date: 01/09/2015
Version: 1.0
Description: This script implements all the business rules to get the CDI attributes required for the collection.
******************************************************************************************************************/

REGISTER '$MADE_JAR_DIR/Search.jar';

/*****************************************************************************************************************
Loading all CDI tables into relations
*****************************************************************************************************************/

load_CnsmrLyltySywrSrcCdi = load '$MAP_PROD_DIR/cdi/CnsmrLyltySywrSrcCdi/current' using PigStorage('\u0001') as
(  processed_tmp:chararray
   ,LyltyCardNbr:chararray
   ,SrcApplCd:chararray
   ,CnsmrId:chararray
   ,RowCreatTs:chararray
   ,RowModTs:chararray );

CnsmrLyltySywrSrcCdi = FOREACH load_CnsmrLyltySywrSrcCdi GENERATE LyltyCardNbr, SrcApplCd, CnsmrId;

load_ConsumerCdi = load '$MAP_PROD_DIR/cdi/ConsumerCdi/current' using PigStorage('\u0001') as
(    processed_tmp:chararray
     ,CnsmrId:chararray
     ,PrevCnsmrId:chararray
     ,CnsmrCnfdncCd:chararray
     ,CnsmrTypeCd :chararray
     ,Bsnss_Cntct_Ind:chararray
     ,PrfxTxt:chararray
     ,GivenNm:chararray
     ,MidNm:chararray
     ,SurNm :chararray
     ,CnsmrNmObscntyInd:chararray
     ,SufxTxt:chararray
     ,GenderCd :chararray
     ,SSADceasInd:chararray
     ,SHCDceasInd:chararray
     ,ThrdPrtyBirthYrMthDt:chararray
     ,SHCBirthDt:chararray
     ,AssocStatCd:chararray
     ,LyltyMbrInd:chararray
     ,CrftsmnClubInd:chararray
     ,KdvntgClubInd:chararray
     ,SrsCrdAcctInd:chararray
     ,SrsPremrCrdAcctInd:chararray
    ,SrsMstrCrdAcctInd:chararray
     ,SrsPremrMstrCrdAcctInd:chararray
     ,TGIMstrCrdAcctInd:chararray
     ,HmImprvmntAcctInd:chararray
     ,WstrnAutoAcctInd :chararray
     ,MdrnzdCrdtPlnAcctInd :chararray
     ,InstldHmImprvmntAcctInd:chararray
     ,SrsChrgPlusAcctInd:chararray
     ,SrsStrtrCrdAcctInd:chararray
     ,CrtBlnchAcctInd:chararray
     ,SrsMerchntAcctInd:chararray
     ,LastIntrctnDt:chararray
     ,CnsmrIdRetrdInd:chararray
     ,CnsmrRcgLastModDt:chararray
     ,NmChkCd:chararray
     ,RowCreatTs:chararray
     ,RowModTs :chararray);

ConsumerCdi = FOREACH load_ConsumerCdi GENERATE CnsmrId,CnsmrCnfdncCd;

load_CnsmrHshldCdi = load '$MAP_PROD_DIR/cdi/CnsmrHshldCdi/current' using PigStorage('\u0001') as
(  processed_tmp:chararray,
   CnsmrId :chararray,
    HshldId :chararray,
    PrevHshldId :chararray,
    EffDt :chararray,
    EndDt :chararray,
    CrrntInd :chararray,
    CnsmrHshldMrktngRnkNbr:chararray,
    RowCreatTs:chararray,
    RowModTs:chararray);


CnsmrHshldCdi = FOREACH load_CnsmrHshldCdi GENERATE CnsmrId, HshldId, PrevHshldId, EffDt, EndDt, CrrntInd, CnsmrHshldMrktngRnkNbr;

load_CnsmrAddrCdi = load '$MAP_PROD_DIR/cdi/CnsmrAddrCdi/current' using PigStorage('\u0001') as
(     processed_tmp:chararray,
      CnsmrId:chararray,
      AddrId:chararray,
      PrmcyCd:chararray,
      CrrntAddrId:chararray,
      PrevAddrId:chararray,
      SchldMoveYrMthNbr:chararray,
      DMADoNotMailInd:chararray,
      DoNotMailInd:chararray,
      RowCreatTs:chararray,
      RowModTs:chararray);

CnsmrAddrCdi = FOREACH load_CnsmrAddrCdi GENERATE CnsmrId, AddrId, PrmcyCd, CrrntAddrId, PrevAddrId, SchldMoveYrMthNbr AS MoveInDate, DMADoNotMailInd, DoNotMailInd;

load_AddrCdi = load '$MAP_PROD_DIR/cdi/AddrCdi/current' using PigStorage('\u0001') as
(    processed_tmp:chararray,
     AddrId:chararray,
     PrevAddrId:chararray,
     AddrLn1Txt:chararray,
     AddrLn2TxAddrt:chararray,
     AddrObscntyInd:chararray,
     UrbanZtnNm:chararray,
     CityNm:chararray,
     StCd:chararray,
     Zip:chararray,
     ZipPlus4:chararray,
     CanadaPrvncCd:chararray,
     CanadaPstlCd:chararray,
     CarrRteTypeCd:chararray,
     CarrRteIn:chararray,
     DlvryPtBarCd:chararray,
     DlvryPtDropCd:chararray,
     DlvryPtDropUnitsSrvcdQty:chararray,
     DlvryPtZipPlus4FndInd:chararray,
     DlvryAssmtRsltCd:chararray,
     AddrDlvryTypeCd:chararray,
     AddrTypeCd:chararray,
     SRRvrsAppendCd:chararray,
     SRRvrsAppendCnfdncCd:chararray,
     NCOAMatchCd:chararray,
     VcncyInd:chararray,
     SeasnlInd:chararray,
     POBoxDlvryInd:chararray,
     LoctblAddrCnvrsnSysInd:chararray,
     CnsmrOrBusInd:chararray,
     LrgPrisonInd:chararray,
     MltryAddrInd:chararray,
     SHCLocnInd:chararray,
     RowCreatTs:chararray,
     RowModTs:chararray);



AddrCdi = FOREACH load_AddrCdi GENERATE AddrId, CONCAT(CONCAT(CONCAT(CONCAT((AddrLn1Txt is not null?AddrLn1Txt:''),(AddrLn2TxAddrt is not null?CONCAT(' ',AddrLn2TxAddrt):'')),(CityNm is not null?CONCAT(' ',CityNm):'')),(StCd is not null?CONCAT(' ',StCd):'')),(Zip is not null?CONCAT(' ',Zip):'')) AS TotAddress;

load_HshldPremrPlusCdi = load '$MAP_PROD_DIR/cdi/HshldPremrPlusCdi/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
,HshldId:chararray
,AdultMale18to24Ind:chararray
,AdultFem18to24Ind:chararray
,AdultUng18to24Ind:chararray
,AdultMale25to34Ind:chararray
,AdultFem25to34Ind:chararray
,AdultUng25to34Ind:chararray
,AdultMale35to44Ind:chararray
,AdultFem35to44Ind:chararray
,AdultUng35to44Ind:chararray
,AdultMale45to54Ind:chararray
,AdultFem45to54Ind:chararray
,AdultUng45to54Ind:chararray
,AdultMale55to64Ind:chararray
,AdultFem55to64Ind:chararray
,AdultUng55to64Ind:chararray
,AdultMale65to74Ind:chararray
,AdultFem65to74Ind:chararray
,AdultUng65to74Ind:chararray
,AdultMale75PlusInd:chararray
,AdultFem75PlusInd:chararray
,AdultUng75PlusInd:chararray
,ChildMale0to2Ind:chararray
,ChildFem0to2Ind:chararray
,ChildUng0to2Ind:chararray
,ChildMale3to5Ind:chararray
,ChildFem3to5Ind:chararray
,ChildUng3to5Ind:chararray
,ChildMale6to10Ind:chararray
,ChildFem6to10Ind:chararray
,ChildUng6to10Ind:chararray
,ChildMale11to15Ind:chararray
,ChildFem11to15Ind:chararray
,ChildUng11to15Ind:chararray
,ChildMale16to17Ind:chararray
,ChildFem16to17Ind:chararray
,ChildUng16to17Ind:chararray
,HmOwnrRntrCd:chararray
,YrsAtRsdncCd:chararray
,MrtlStatCd:chararray
,AdultCntCd:chararray
,OccpntCntCd:chararray
,ChildHshldQty:chararray
,EstmtdTncmCd:chararray
,ChildPrsncInd:chararray
,RowCreatTs:chararray
,RowModTs:chararray
);


HshldPremrPlusCdi = FOREACH load_HshldPremrPlusCdi GENERATE HshldId,HmOwnrRntrCd,YrsAtRsdncCd,EstmtdTncmCd,OccpntCntCd,ChildMale0to2Ind,ChildMale3to5Ind,ChildMale6to10Ind,ChildMale11to15Ind,ChildMale16to17Ind,ChildFem0to2Ind,ChildFem3to5Ind,ChildFem6to10Ind,ChildFem11to15Ind,ChildFem16to17Ind,(MrtlStatCd=='M'?'Married':(MrtlStatCd=='S'?'Single':(MrtlStatCd=='A'?'Inferred Married':(MrtlStatCd=='B'?'Inferred Single':'NOT-AVAILABLE')))) AS MrtlStatDesc;

load_Hshld_Geocd = load '$MAP_PROD_DIR/cdi/HshldGeocdCdi/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
,HshldId:chararray
,LatDegQty:chararray
,LongtdDegQty:chararray
,LatRdnQty:chararray
,LongtRdnQty:chararray
,MatchLvlCd:chararray
,CenFipsStCd:chararray
,CenFipsCntryCd:chararray
,CenTractCd:chararray
,CenBlockCd:chararray
,CenFipsMcdCd:chararray
,CenFipsPlcCd:chararray
,CenMsaCd:chararray
,CenCbsaCd:chararray
,CenMcdCd:chararray
,CenPlcCd:chararray
,RowCreatTs:chararray
,RowModTs:chararray
);


Hshld_Geocd = FOREACH load_Hshld_Geocd GENERATE HshldId, LatDegQty, LongtdDegQty, LatRdnQty, LongtRdnQty;

load_HshldHighTechCdi = load '$MAP_PROD_DIR/cdi/HshldHighTechCdi/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
,HshldId:chararray
,ComptrPltfmCd:chararray
,OperSysCd:chararray
,SftwrBuyerInd:chararray
,SftwrRcntNbr:chararray
,SftwrTranQty:chararray
,StreoInd:chararray
,RowCreatTs:chararray
,RowModTs:chararray
);

HshldHighTechCdi = FOREACH load_HshldHighTechCdi GENERATE HshldId, ComptrPltfmCd, OperSysCd;

load_HshldLfstlCdi = load '$MAP_PROD_DIR/cdi/HshldLfstlCdi/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
,HshldId:chararray
,DomestInd:chararray
,DiyInd:chararray
,AthlcInd:chararray
,GoodLifeInd:chararray
,CltrlInd:chararray
,BlueChipInd:chararray
,TechInd:chararray
,CmposCollctInd:chararray
,CmposTrdstInd:chararray
,CmposPrfsnInd:chararray
,CmposIntgtsaInd:chararray
,CmposReadInd:chararray
,CmposChipheadInd:chararray
,CmposTVGuidInd:chararray
,MoneyMakeOppInd:chararray
,NatlHrtgeInd:chararray
,WatchTVSprtInd:chararray
,HmVideoRecInd:chararray
,PwrBoatgInd:chararray
,VtranInd:chararray
,RowcreatTs:chararray
,RowModTs:chararray
);


HshldLfstlCdi = FOREACH load_HshldLfstlCdi GENERATE HshldId, DiyInd;

load_HshldLftrtsCdi = load '$MAP_PROD_DIR/cdi/HshldLftrtsCdi/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
,HshldId:chararray
,LftAntqCllInd:chararray
,LftElecCmptrInd:chararray
,LftExerHlthInd:chararray
,LftFoodCokngInd:chararray
,LftHmImprvInd:chararray
,LftInvesFinanInd:chararray
,LftOutdInd:chararray
,LftReadInd:chararray
,LftSprtInd:chararray
,LftStreoVideoInd:chararray
,LftTravInd:chararray
,CllGenlInd:chararray
,CllStampInd:chararray
,CllCoinInd:chararray
,CllArtInd:chararray
,CllAntqInd:chararray
,ElecClulrPhoneOwnerInd:chararray
,ElecCnsmrElecInd:chararray
,ExerRunJoggngInd:chararray
,ExerWalkInd:chararray
,ExerAerbcCrvscInd:chararray
,FamlyCatOwnerInd:chararray
,FamlyDogOwnerInd:chararray
,FamlyOtherPetOwnerInd:chararray
,FamlyHousePlantInd:chararray
,FamlyParInd:chararray
,FamlyChildIntInd:chararray
,FamlyGchInd:chararray
,FoodCokngGenlInd:chararray
,FoodCokngGormtInd:chararray
,FoodCokngLowFatInd:chararray
,FoodCokngVegInd:chararray
,FoodCokngNatrFoodInd:chararray
,GamContstGamblingStLttryInd:chararray
,GamContstGamblingCsinoInd:chararray
,GamContstGamblingSwstkInd:chararray
,HlthSelfImprvGenlInd:chararray
,HlthSelfImprvDietWtLossInd:chararray
,HlthSelfImprvInd:chararray
,HobbCrftsInd:chararray
,HobbPhotoInd:chararray
,HobbAvtnInd:chararray
,HobbAutoMchncInd:chararray
,HobbSewKntwNdlwkInd:chararray
,HobbWdwrkInd:chararray
,HobbBoardGamPzzlInd:chararray
,HmCmptrOwnerInd:chararray
,HmCmptrInetOnlineServInd:chararray
,HmCmptrModemOwnerInd:chararray
,HmCmptrPlayCmptrGamInd:chararray
,HmImprvFrnshDcrtnInd:chararray
,HmImprvInd:chararray
,HmImprvGardnInd:chararray
,HmVideoCllMoviInd:chararray
,HmVideoCblTvInd:chararray
,HmVideoPlayVideoGamInd:chararray
,HmVideoPlayOwnerInd:chararray
,HmVideoStlltDishInd:chararray
,IntFashInd:chararray
,IntHistMltryInd:chararray
,IntSmkTbcInd:chararray
,IntClbrtInd:chararray
,IntCurAfrPolInd:chararray
,IntThtrPerfngArtsInd:chararray
,IntCmmtyChrtyInd:chararray
,IntRlgnInsprtnlInd:chararray
,IntScncSpcInd:chararray
,IntStrngeUnsualInd:chararray
,IntCareerImprvInd:chararray
,IntWinesInd:chararray
,IntArtsInd:chararray
,InvstFinanPersInvstInd:chararray
,InvstFinanReInvstInd:chararray
,InvstFinanStkBondInvstInd:chararray
,OutdFishInd:chararray
,OutdCmpgHkngInd:chararray
,OutdHuntShoInd:chararray
,OutdBoatgSailgInd:chararray
,OutdWaterSprtInd:chararray
,OutdScuInd:chararray
,OutdBcyclMountnBcyclInd:chararray
,OutdEnvirIssueInd:chararray
,PartcpSprtTennsInd:chararray
,PartcpSprtGolfInd:chararray
,PartcpSprtSnowSkngInd:chararray
,PartcpSprtMtrcyInd:chararray
,PartcpSprtEqstrianInd:chararray
,ReadGenInd:chararray
,ReadTopSllrsInd:chararray
,ReadRlgnInsprtnlInd:chararray
,ReadScncFxnInd:chararray
,ReadMgznInd:chararray
,ReadAudioBookInd:chararray
,SpctrSprtAutoCycleRaceInd:chararray
,SpctrSprtFtbInd:chararray
,SpctrSprtBsbInd:chararray
,SpctrSprtBskInd:chararray
,SpctrSprtHkyInd:chararray
,SpctrSprtSoccerInd:chararray
,SpctrSprtTnnsInd:chararray
,StreoHmStreoOwnerInd:chararray
,StreoCdPlayOwnerInd:chararray
,StreoRecTapeCllInd:chararray
,StreoAvidMusLsnInd:chararray
,TravUsaInd:chararray
,TravForgnInd:chararray
,TravRvInd:chararray
,TravFamlyVacInd:chararray
,TravCruiseVacInd:chararray
,IntCareerInd:chararray
,IntHmImprvDoItYrslfInd:chararray
,RowCreatTs:chararray
,RowModTs:chararray
);


HshldLftrtsCdi = FOREACH load_HshldLftrtsCdi GENERATE HshldId, HobbCrftsInd,HobbPhotoInd, HobbAvtnInd, HobbAutoMchncInd, HobbSewKntwNdlwkInd, HobbWdwrkInd, HobbBoardGamPzzlInd, HmCmptrOwnerInd, HmCmptrInetOnlineServInd, HmCmptrPlayCmptrGamInd, PartcpSprtTennsInd, PartcpSprtGolfInd, PartcpSprtSnowSkngInd, PartcpSprtMtrcyInd, PartcpSprtEqstrianInd, SpctrSprtAutoCycleRaceInd, SpctrSprtFtbInd, SpctrSprtBsbInd, SpctrSprtBskInd, SpctrSprtHkyInd, SpctrSprtSoccerInd, SpctrSprtTnnsInd, FamlyDogOwnerInd, FamlyCatOwnerInd, FamlyOtherPetOwnerInd, ElecClulrPhoneOwnerInd, ElecCnsmrElecInd, ExerAerbcCrvscInd, ExerRunJoggngInd, ExerWalkInd, FamlyChildIntInd, FamlyGchInd;

load_HshldMotrVhclCdi = load '$MAP_PROD_DIR/cdi/HshldMotrVhclCdi/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
,HshldId:chararray
,TruckOwnerInd:chararray
,MtrcyOwnerInd:chararray
,RvOwnerInd:chararray
,RowCreatTs:chararray
,RowModTs:chararray
);

HshldMotrVhclCdi = FOREACH load_HshldMotrVhclCdi GENERATE HshldId, TruckOwnerInd, MtrcyOwnerInd, RvOwnerInd;

load_HshldPurchBhvrCdi = load '$MAP_PROD_DIR/cdi/HshldPurchBhvrCdi/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
,HshldId:chararray
, MailOrdDonorInd:chararray
, CtlgShwrmRetlBuyerInd:chararray
, ComptrElecBuyerInd:chararray
, FinanServBankInd:chararray
, FinanServInstlCrInd:chararray
, FnianServInsurInd:chararray
, FurnBuyerInd:chararray
, GrocInd:chararray
, HighEndRetlBuyerUpsclRetlInd:chararray
, HighVolLowEndDeptStrInd:chararray
, HmofcSuplPurchInd:chararray
, HmImprvInd:chararray
, MainStrtRetlInd:chararray
, MbrWhseInd:chararray
, MiscInd:chararray
, OilCoInd:chararray
, SpclInd:chararray
, SpclApprlInd:chararray
, SprtGoodsInd:chararray
, StdRetlInd:chararray
, TravPersServInd:chararray
, TvMailOrdPurchInd:chararray
, LastShopDt:chararray
, CrCardUserInd:chararray
, NewBankCardIssueInd:chararray
, BankCardPrsncInd:chararray
, LinesOfCrtQty:chararray
, NewCardtRngCd:chararray
, CrCardPurchLast03MthQty:chararray
, CrCardPurchLast46MthQty:chararray
, CrCardPurchLast79MthQty:chararray
, CrCardPurchLast1012MthQty:chararray
, CrCardPurchLast1318MthQty:chararray
, CrCardPurchLast1924MthQty:chararray
, CrCardPurch24OrMoreMthQty:chararray
, MostFreqRetlPurchCatgCd:chararray
, RcntRetlPurchCatg1Cd:chararray
, RcntRetlPurchCatg1Dt:chararray
, RcntRetlPurchCatg2Cd:chararray
, RcntRetlPurchCatg2Dt:chararray
, RcntRetlPurchCatg3Cd:chararray
, RcntRetlPurchCatg3Dt:chararray
, RcntRetlPurchCatg4Cd:chararray
, RcntRetlPurchCatg4Dt:chararray
, RcntRetlPurchCatg5Cd:chararray
, RcntRetlPurchCatg5Dt:chararray
, MailOrdBuyerWomanApprlInd:chararray
, MailOrdBuyerJwlryFashInd:chararray
, MailOrdBuyerMaleApprlInd:chararray
, MailOrdBuyerWomanClothPSizInd:chararray
, MailOrdBuyerTngFashInd:chararray
, MailOrdBuyerUnkTypeInd:chararray
, MailOrdBuyerArtAndAntqInd:chararray
, MailOrdBuyerArtAndCrftsInd:chararray
, MailOrdBuyerAutoSuplInd:chararray
, MailOrdBuyerBtyInd:chararray
, MailOrdBuyerBookInd:chararray
, MailOrdBuyerChildMerchInd:chararray
, MailOrdBuyerCllInd:chararray
, MailOrdBuyerCmptrSftwrInd:chararray
, MailOrdBuyrElecInd:chararray
, MailOrdBuyrEqstrianInd:chararray
, MailOrdBuyrFoodInd:chararray
, MailOrdBuyrGenlGiftMerchInd:chararray
, MailOrdBuyrGiftInd:chararray
, MailOrdBuyrHlthInd:chararray
, MailOrdBuyrHmFrnshDcrtnInd:chararray
, MailOrdBuyrHighTcktMerchInd:chararray
, MailOrdBuyrLowTcktMerchInd:chararray
, MailOrdBuyrMusicInd:chararray
, MailOrdBuyrOutdGardnInd:chararray
, MailOrdBuyrOutdHuntFishInd:chararray
, MailOrdBuyrPetSuplInd:chararray
, MailOrdBuyrSprtGolfInd:chararray
, MailOrdBuyrSprtInd:chararray
, MailOrdBuyrTravInd:chararray
, MailOrdBuyrVideoDvdInd:chararray
, DonteChrtablCauseInd:chararray
, DonteAnimlWelfareInd:chararray
, DonteArtOrCltrlInd:chararray
, DonteChildCauseInd:chararray
, DonteEnvirOrWldlfInd:chararray
, DonteHlthCauseInd:chararray
, DonteIntlAidInd:chararray
, DontePolCauseInd:chararray
, DonteConsrvtvCauseInd:chararray
, DonteLibrlCauseInd:chararray
, DonteRlgnCauseInd:chararray
, DonteVtranCauseInd:chararray
, DonteOtherCauseInd:chararray
, OnlinePurchrInd:chararray
, BankCardHldrInd:chararray
, GasDeptRetlCardHldrInd:chararray
, TravEntrtnCardHldrInd:chararray
, CrCardHldrUnkTypeInd:chararray
, PremGoldCardHldrInd:chararray
, UpsclDeptStrCardHldrInd:chararray
, GoldPremAmexCardUserInd:chararray
, RegAmexCardUserInd:chararray
, GoldPremDiscvCardUserInd:chararray
, RegDiscvCardUserInd:chararray
, PremGasRetlCardUserInd:chararray
, RegGasRetlCardUserInd:chararray
, GoldPremMtrcdUserInd:chararray
, RegMtrcdUserInd:chararray
, GoldPremVisaCardUserInd:chararray
, RegVisaCardUserInd:chararray
, RowCreatTS:chararray
, RowModTs:chararray
);


HshldPurchBhvrCdi = FOREACH load_HshldPurchBhvrCdi GENERATE HshldId, DonteRlgnCauseInd, DonteVtranCauseInd, DonteChrtablCauseInd, CrCardUserInd, DontePolCauseInd, DonteConsrvtvCauseInd, DonteLibrlCauseInd, DonteAnimlWelfareInd, DonteArtOrCltrlInd, DonteChildCauseInd, DonteEnvirOrWldlfInd, DonteHlthCauseInd, DonteIntlAidInd, DonteOtherCauseInd;

load_HshldNonBuyrOthrCdi = load '$MAP_PROD_DIR/cdi/HshldNonBuyrOthrCdi/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
,HshldId:chararray
, AdultMale18to24Ind:chararray
, AdultFem18to24Ind:chararray
, AdultUng18to24Ind:chararray
, AdultMale25to34Ind:chararray
, AdultFem25to34Ind:chararray
, AdultUng25to34Ind:chararray
, AdultMale35to44Ind:chararray
, AdultFem35to44Ind:chararray
, AdultUng35to44Ind:chararray
, AdultMale45to54Ind:chararray
, AdultFem45to54Ind:chararray
, AdultUng45to54Ind:chararray
, AdultMale55to64Ind:chararray
, AdultFem55to64Ind:chararray
, AdultUng55to64Ind:chararray
, AdultMale65to74Ind:chararray
, AdultFem65to74Ind:chararray
, AdultUng65to74Ind:chararray
, AdultMale75PlusInd:chararray
, AdultFem75PlusInd:chararray
, AdultUng75PlusInd:chararray
, ChildMale0to2Ind:chararray
, ChildFem0to2Ind:chararray
, ChildUng0to2Ind:chararray
, ChildMale3to5Ind:chararray
, ChildFem3to5Ind:chararray
, ChildUng3to5Ind:chararray
, ChildMale6to10Ind:chararray
, ChildFem6to10Ind:chararray
, ChildUng6to10Ind:chararray
, ChildMale11to15Ind:chararray
, ChildFem11to15Ind:chararray
, ChildUng11to15Ind:chararray
, ChildMale16to17Ind:chararray
, ChildFem16to17Ind:chararray
, ChildUng16to17Ind:chararray
, HmOwnrRntrCd:chararray
, YrsAtRsdncCd:chararray
, DwllingUnitTypeCd:chararray
, MrtlStatCd:chararray
, LastVfyYrNbr:chararray
, LastVfyQtrNbr:chararray
, MailOrdBuyerInd:chararray
, WrkngFemInd:chararray
, MailRspInd:chararray
, CrCardBnkCardHldrInd:chararray
, CrCardRetlHldrInd:chararray
, CrCardTravEntrtnHldrInd:chararray
, CrCardUnkTypeInd:chararray
, CrCardPremrGoldInd:chararray
, CrCardUpsclStrInd:chararray
, MatchCnsmrBirthDt:chararray
, MatchBirthDtCnsmrCd:chararray
, AdultCntCd:chararray
, OccpntCntCd:chararray
, DmgrphcsSrcCntCd:chararray
, EstmtdTncmCd:chararray
, HmMktValCd:chararray
, HmAvailEqtyCd:chararray
, HmPurchYrNbr:chararray
, HmPurchMthNbr:chararray
, NewVehBuyerLeaseInd:chararray
, VehCntCd:chararray
, VehDmnLfstyCd:chararray
, InfrHshldRnkCd:chararray
, DmaDoNotMailInd:chararray
, ChildPrsncInd:chararray
, YngAdultPrsncInd:chararray
, SrAdultPrsncInd:chararray
, OverallMatchCd:chararray
, InfbsePostvMatchCd:chararray
, EstHighIncmCd:chararray
, HmofcUserCd:chararray
, ChildHshldQty:chararray
, LfstgSegCd:chararray
, LfstgsSubsegCd:chararray
, PrsxClusCd:chararray
, PrsxPcisnLvlCd:chararray
, LifeEvntCollgGradnInd:chararray
, LifeEvntEmptyNestrInd:chararray
, LifeEvntEntrAdulthdInd:chararray
, LifeEvntExpectParInd:chararray
, LifeEvntVhclPurchIntentInd:chararray
, LifeEvntRcntDvcInd:chararray
, LifeEvntNewlywedInd:chararray
, LifeEvntNewParCd:chararray
, LifeEvntChildNrHsGradtnInd:chararray
, LifeEvntRcntHmBuyerInd:chararray
, LifeEvntRcntMortBrrwrInd:chararray
, LifeEvntNewMoveInd:chararray
, SnglParHshldInd:chararray
, LfInsurPlcyOwnerInd:chararray
, LowDtlRaceCd:chararray
, CntryOfOrigCd:chararray
, HispLangPrefCd:chararray
, RowCreatTs:chararray
, RowModTs:chararray
);


HshldNonBuyrOthrCdi = FOREACH load_HshldNonBuyrOthrCdi GENERATE HshldId, VehCntCd, LifeEvntCollgGradnInd, LifeEvntEmptyNestrInd, LifeEvntEntrAdulthdInd, LifeEvntExpectParInd, LifeEvntVhclPurchIntentInd, LifeEvntNewlywedInd, LifeEvntRcntDvcInd, LifeEvntChildNrHsGradtnInd, LifeEvntRcntHmBuyerInd, LifeEvntRcntMortBrrwrInd, LifeEvntNewMoveInd, LifeEvntNewParCd,LowDtlRaceCd;

load_HshldPrprtyCdi = load '$MAP_PROD_DIR/cdi/HshldPrprtyCdi/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
,HshldId:chararray
, HmMrktValuDciCd:chararray
, PropTypeCd:chararray
, LoanToValuPctCd:chararray
, HmLendblEqtyCd:chararray
, HmSqftgCd:chararray
, LotSizeCd:chararray
, ProjInsurLoanExpirMthNbr:chararray
, ProjInsurPurchExpirMthNbr:chararray
, SwimPoolInd:chararray
, HmConstrYrNbr:chararray
, HmConstrYrRngCd:chararray
, CmmtyReinvstActIncmClsCd:chararray
, TotHmLoanRngCd:chararray
, HmPurchAmtRngCd:chararray
, HmEqtyAvailRngCd:chararray
, HmAsessdValuRngCd:chararray
, ActlHmLoanAmt:chararray
, ActlHmLoanEqtyAmt:chararray
, ActlHmEqtAvailAmt:chararray
, HmRoomQty:chararray
, HmHeatCoolCd:chararray
, HmExteriorCd:chararray
, HmRoofTypeCd:chararray
, HmHeatSrcCd:chararray
, OwnerTypeDtlCd:chararray
, TrustOwnedCd:chararray
, PropTypePremrCd:chararray
, HmPropTypeCd:chararray
, HmOwnerCd:chararray
, HmPurchYrMthNbr:chararray
, HmPurchYrNbr:chararray
, HmConstrYrOldrRngCd:chararray
, RowCreatTs:chararray
, RowModTs:chararray
);
HshldPrprtyCdi = FOREACH load_HshldPrprtyCdi GENERATE HshldId, PropTypeCd, LotSizeCd, HmMrktValuDciCd, HmConstrYrNbr, HmEqtyAvailRngCd, HmSqftgCd, HmExteriorCd, HmHeatSrcCd, HmRoofTypeCd, HmRoomQty, SwimPoolInd;


load_HshldCnsmrCdi = load '$MAP_PROD_DIR/cdi/HshldCnsmrCdi/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
,HshldId:chararray
, CnsmrId:chararray
, CnsmrSeqNbr:chararray
, FirstNm:chararray
, MidInitl:chararray
, GenderCd:chararray
, BirthDt:chararray
, AgeCd:chararray
, OccupCd:chararray
, EduCd:chararray
, VotrPartyCd:chararray
, RaceCd:chararray
, ApplFirstAgeCd:chararray
, ApplFirstEduCd:chararray
, ApcFirstAgeCd:chararray
, ApcFirstAgeMatchCdLvlCd:chararray
, ApcFirstEduCd:chararray
, ApcFirstEduMatchLvlCd:chararray
, RowCreatTs:chararray
, RowcModTs:chararray
);

HshldCnsmrCdi = FOREACH load_HshldCnsmrCdi GENERATE HshldId, CnsmrId, BirthDt, GenderCd, AgeCd, RaceCd, OccupCd, EduCd, VotrPartyCd;

load_HmOwnerRentrCdLu = load '$MAP_PROD_DIR/lookups/HmOwnerRentrCdLu/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
, HmOwnerRentrCd:chararray
, HmOwnerRentrCdDesc:chararray
, RowCreatTs:chararray
, RowcModTs:chararray
);

HmOwnerRentrCdLu = FOREACH load_HmOwnerRentrCdLu GENERATE HmOwnerRentrCd, HmOwnerRentrCdDesc;


load_YrAtResCdLu = load '$MAP_PROD_DIR/lookups/YrAtResCdLu/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
, YrAtResCd:chararray
, YrAtResCdDesc:chararray
, RowCreatTs:chararray
, RowcModTs:chararray
);

YrAtResCdLu = FOREACH load_YrAtResCdLu GENERATE YrAtResCd, YrAtResCdDesc;

load_EstIncmCdLu = load '$MAP_PROD_DIR/lookups/EstIncmCdLu/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
, EstIncmCd:chararray
, EstIncmCdDesc:chararray
, RowCreatTs:chararray
, RowcModTs:chararray
);

EstIncmCdLu = FOREACH load_EstIncmCdLu GENERATE EstIncmCd, EstIncmCdDesc;

load_OccupntCntCdLu = load '$MAP_PROD_DIR/lookups/OccupntCntCdLu/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
, OccupntCntCd:chararray
, OccupntCntCdDesc:chararray
, RowCreatTs:chararray
, RowcModTs:chararray
);

OccupntCntCdLu = FOREACH load_OccupntCntCdLu GENERATE OccupntCntCd, OccupntCntCdDesc;

load_OperSysCdLu = load '$MAP_PROD_DIR/lookups/OperSysCdLu/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
, OperSysCd:chararray
, OperSysCdDesc:chararray
, RowCreatTs:chararray
, RowcModTs:chararray
);

OperSysCdLu = FOREACH load_OperSysCdLu GENERATE OperSysCd, OperSysCdDesc;

load_AgeLu = load '$MAP_PROD_DIR/lookups/AgeLu/current' using PigStorage('\u0001') as
(
processed_tmp:chararray
, Age:chararray
, AgeDesc:chararray
, RowCreatTs:chararray
, RowModTs:chararray);

AgeLu = FOREACH load_AgeLu GENERATE Age, AgeDesc;

load_GenderCdLu = load '$MAP_PROD_DIR/lookups/GenderCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray
, GenderCd:chararray
      ,GenderCdDesc:chararray
      ,RowCreatTs:chararray
      ,RowModTs:chararray);

GenderCdLu = FOREACH load_GenderCdLu GENERATE GenderCd, GenderCdDesc;


load_PropTypeCdLu = load '$MAP_PROD_DIR/lookups/PropTypeCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray
, PropTypeCd:chararray
      ,PropTypeCdDesc:chararray
      ,RowCreatTs:chararray
      ,RowModTs:chararray);

PropTypeCdLu = FOREACH load_PropTypeCdLu GENERATE PropTypeCd, PropTypeCdDesc;

load_LotSizeCdLu = load '$MAP_PROD_DIR/lookups/LotSizeCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray
, LotSizeCd:chararray
      ,LotSizeCdDesc:chararray
      ,RowCreatTs:chararray
      ,RowModTs:chararray);

LotSizeCdLu = FOREACH load_LotSizeCdLu GENERATE LotSizeCd, LotSizeCdDesc;

load_HmMrktValuDciCdLu = load '$MAP_PROD_DIR/lookups/HmMrktValuDciCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray
, HmMrktValuDciCd:chararray
      ,HmMrktValuDciCdDesc:chararray
      ,RowCreatTs:chararray
      ,RowModTs:chararray);

HmMrktValuDciCdLu = FOREACH load_HmMrktValuDciCdLu GENERATE HmMrktValuDciCd, HmMrktValuDciCdDesc;

load_HmEqtyAvailRngCdLu = load '$MAP_PROD_DIR/lookups/HmEqtyAvailRngCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray
, HmEqtyAvailRngCd:chararray
      ,HmEqtyAvailRngCdDesc:chararray
      ,RowCreatTs:chararray
      ,RowModTs:chararray);

HmEqtyAvailRngCdLu = FOREACH load_HmEqtyAvailRngCdLu GENERATE HmEqtyAvailRngCd, HmEqtyAvailRngCdDesc;

load_HmSqftgCdLu = load '$MAP_PROD_DIR/lookups/HmSqftgCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray
, HmSqftgCd:chararray
      ,HmSqftgCdDesc:chararray
      ,RowCreatTs:chararray
      ,RowModTs:chararray);

HmSqftgCdLu = FOREACH load_HmSqftgCdLu GENERATE HmSqftgCd, HmSqftgCdDesc;

load_HmExteriorCdLu = load '$MAP_PROD_DIR/lookups/HmExteriorCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray
, HmExteriorCd:chararray
      ,HmExteriorCdDesc:chararray
      ,RowCreatTs:chararray
      ,RowModTs:chararray);

HmExteriorCdLu = FOREACH load_HmExteriorCdLu GENERATE HmExteriorCd, HmExteriorCdDesc;

load_HmHeatSrcCdLu = load '$MAP_PROD_DIR/lookups/HmHeatSrcCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray
, HmHeatSrcCd:chararray
      ,HmHeatSrcCdDesc:chararray
      ,RowCreatTs:chararray
      ,RowModTs:chararray);

HmHeatSrcCdLu = FOREACH load_HmHeatSrcCdLu GENERATE HmHeatSrcCd, HmHeatSrcCdDesc;


load_HomeRoofTypeCdLu = load '$MAP_PROD_DIR/lookups/HomeRoofTypeCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray
, HmRoofTypeCd:chararray
      ,HmRoofTypeCdDesc:chararray
      ,RowCreatTs:chararray
      ,RowModTs:chararray);

HomeRoofTypeCdLu = FOREACH load_HomeRoofTypeCdLu GENERATE HmRoofTypeCd, HmRoofTypeCdDesc;


load_VehCntCdLu = load '$MAP_PROD_DIR/lookups/VehCntCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray
, VehCntCd:chararray
      ,VehCntCdDesc:chararray
      ,RowCreatTs:chararray
      ,RowModTs:chararray);

VehCntCdLu = FOREACH load_VehCntCdLu GENERATE VehCntCd, VehCntCdDesc;

load_RaceCdLu = load '$MAP_PROD_DIR/lookups/RaceCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray,
RaceCd:chararray,
RaceCdDesc:chararray,
RowCreatTs:chararray,
RowModTs:chararray
);

RaceCdLu = FOREACH load_RaceCdLu GENERATE RaceCd, RaceCdDesc;

load_OccupCdLu = load '$MAP_PROD_DIR/lookups/OccupCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray,
OccupCd:chararray,
OccupCdDesc:chararray,
RowCreatTs:chararray,
RowModTs:chararray
);

OccupCdLu = FOREACH load_OccupCdLu GENERATE OccupCd, OccupCdDesc;

load_VotrPartyCdLu = load '$MAP_PROD_DIR/lookups/VotrPartyCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray,
VotrPartyCd:chararray,
VotrPartyCdDesc:chararray,
RowCreatTs:chararray,
RowModTs:chararray
);

VotrPartyCdLu = FOREACH load_VotrPartyCdLu GENERATE VotrPartyCd, VotrPartyCdDesc;

load_LifeEvntNewParCdLu = load '$MAP_PROD_DIR/lookups/LifeEvntNewParCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray
, LifeEvntNewParCd:chararray,
LifeEvntNewParCdDesc:chararray,
RowCreatTs:chararray,
RowModTs:chararray);

LifeEvntNewParCdLu = FOREACH load_LifeEvntNewParCdLu GENERATE LifeEvntNewParCd, LifeEvntNewParCdDesc;

load_EduLvlCdLu = load '$MAP_PROD_DIR/lookups/EduLvlCdLu/current' using PigStorage('\u0001') as
(processed_tmp:chararray
, EduLvlCd:chararray,
EduLvlCdDesc:chararray,
RowCreatTs:chararray,
RowModTs:chararray);

EduLvlCdLu = FOREACH load_EduLvlCdLu GENERATE EduLvlCd, EduLvlCdDesc;

--join_CnsmrLyltySywrSrcCdi_ActvSywrMbr = join ActvSywrMbr by LyltyCardNbr, CnsmrLyltySywrSrcCdi by CnsmrLyltySywrSrcCdi::LyltyCardNbr;

join_sywr_Cnsmr = join CnsmrLyltySywrSrcCdi by CnsmrId left outer, ConsumerCdi by CnsmrId;

filter_ConsumerCdi = FILTER join_sywr_Cnsmr BY CnsmrCnfdncCd == 'H';

join_sywr_Cnsmr_CnsmrHshld = join filter_ConsumerCdi by CnsmrLyltySywrSrcCdi::CnsmrId left outer, CnsmrHshldCdi by CnsmrId;

filter_crrnt_ind = filter join_sywr_Cnsmr_CnsmrHshld by CnsmrHshldCdi::CrrntInd =='Y';

join_filter_crrnt_int_load_CnsmrAddr = join filter_crrnt_ind by ConsumerCdi::CnsmrId left outer, CnsmrAddrCdi by CnsmrId;

filter_crrnt_int_CnsmrAddr = filter join_filter_crrnt_int_load_CnsmrAddr by CnsmrAddrCdi::CrrntAddrId=='Y'; /*Pick only active addresses*/

join_crrnt_int_load_CnsmrAddr_Addr = join filter_crrnt_int_CnsmrAddr by CnsmrAddrCdi::AddrId left outer, AddrCdi by AddrId;

join_CnsmrHshldCdi_HshldCnsmrCdi = join join_crrnt_int_load_CnsmrAddr_Addr by (CnsmrHshldCdi::CnsmrId, CnsmrHshldCdi::HshldId) left outer, HshldCnsmrCdi by (CnsmrId,HshldId);

join_CnsmrHshldCdi_HshldPremrPlus = join join_CnsmrHshldCdi_HshldCnsmrCdi by CnsmrHshldCdi::HshldId left outer, HshldPremrPlusCdi by HshldId;

join_HshldCnsmrCdi_GenderCdLu = join join_CnsmrHshldCdi_HshldPremrPlus by HshldCnsmrCdi::GenderCd left outer, GenderCdLu by GenderCd USING 'replicated'; 

join_HshldCnsmrCdi_AgeLu = join join_HshldCnsmrCdi_GenderCdLu by HshldCnsmrCdi::AgeCd left outer, AgeLu by Age USING 'replicated';

join_HshldPremrPlus_HmOwnerRentrCdLu = join join_HshldCnsmrCdi_AgeLu by HshldPremrPlusCdi::HmOwnrRntrCd left outer, HmOwnerRentrCdLu by HmOwnerRentrCd USING 'replicated';

join_HshldPremrPlus_YrAtResCdLu = join join_HshldPremrPlus_HmOwnerRentrCdLu by HshldPremrPlusCdi::YrsAtRsdncCd left outer, YrAtResCdLu by YrAtResCd USING 'replicated';

join_HshldPremrPlus_EstIncmCdLu = join join_HshldPremrPlus_YrAtResCdLu by HshldPremrPlusCdi::EstmtdTncmCd left outer, EstIncmCdLu by EstIncmCd USING 'replicated';

join_HshldPremrPlus_OccupntCntCdLu = join join_HshldPremrPlus_EstIncmCdLu by HshldPremrPlusCdi::OccpntCntCd left outer, OccupntCntCdLu by OccupntCntCd USING 'replicated';

join_HshldCnsmrCdi_Hshld_Geocd = join Hshld_Geocd by HshldId right outer, join_HshldPremrPlus_OccupntCntCdLu by CnsmrHshldCdi::HshldId;

join_HshldCnsmrCdi_HshldHighTechCdi = join join_HshldCnsmrCdi_Hshld_Geocd by CnsmrHshldCdi::HshldId left outer, HshldHighTechCdi by HshldId;

join_HshldHighTechCdi_OperSysCdLu = join join_HshldCnsmrCdi_HshldHighTechCdi by HshldHighTechCdi::OperSysCd left outer, OperSysCdLu by OperSysCd USING 'replicated';

join_HshldCnsmrCdi_HshldLfstlCdi = join join_HshldHighTechCdi_OperSysCdLu by CnsmrHshldCdi::HshldId left outer, HshldLfstlCdi by HshldId;

join_HshldCnsmrCdi_HshldLftrtsCdi = join join_HshldCnsmrCdi_HshldLfstlCdi by CnsmrHshldCdi::HshldId left outer, HshldLftrtsCdi by HshldId;

join_HshldCnsmrCdi_HshldMotrVhclCdi = join join_HshldCnsmrCdi_HshldLftrtsCdi by CnsmrHshldCdi::HshldId left outer, HshldMotrVhclCdi by HshldId;

join_HshldCnsmrCdi_HshldNonBuyrOthrCdi = join join_HshldCnsmrCdi_HshldMotrVhclCdi by CnsmrHshldCdi::HshldId left outer, HshldNonBuyrOthrCdi by HshldId;

join_HshldNonBuyrOthrCdi_VehCntCdLu = join join_HshldCnsmrCdi_HshldNonBuyrOthrCdi by HshldNonBuyrOthrCdi::VehCntCd left outer, VehCntCdLu by VehCntCd USING 'replicated';

join_HshldCnsmrCdi_HshldPrprtyCdi = join join_HshldNonBuyrOthrCdi_VehCntCdLu by CnsmrHshldCdi::HshldId left outer, HshldPrprtyCdi by HshldId;

join_HshldPrprtyCdi_PropTypeCdLu = join join_HshldCnsmrCdi_HshldPrprtyCdi by HshldPrprtyCdi::PropTypeCd left outer, PropTypeCdLu by PropTypeCd USING 'replicated';

join_HshldPrprtyCdi_LotSizeCdLu = join join_HshldPrprtyCdi_PropTypeCdLu by HshldPrprtyCdi::LotSizeCd left outer, LotSizeCdLu by LotSizeCd USING 'replicated';

join_HshldPrprtyCdi_HmMrktValuDciCdLu = join join_HshldPrprtyCdi_LotSizeCdLu by HshldPrprtyCdi::HmMrktValuDciCd left outer, HmMrktValuDciCdLu by HmMrktValuDciCd USING 'replicated';

join_HshldPrprtyCdi_HmEqtyAvailRngCdLu = join join_HshldPrprtyCdi_HmMrktValuDciCdLu by HshldPrprtyCdi::HmEqtyAvailRngCd left outer, HmEqtyAvailRngCdLu by HmEqtyAvailRngCd USING 'replicated';

join_HshldPrprtyCdi_HmSqftgCdLu = join join_HshldPrprtyCdi_HmEqtyAvailRngCdLu by HshldPrprtyCdi::HmSqftgCd left outer, HmSqftgCdLu by HmSqftgCd USING 'replicated';

join_HshldPrprtyCdi_HmExteriorCdLu = join join_HshldPrprtyCdi_HmSqftgCdLu by HshldPrprtyCdi::HmExteriorCd left outer, HmExteriorCdLu by HmExteriorCd USING 'replicated';

join_HshldPrprtyCdi_HmHeatSrcCdLu = join join_HshldPrprtyCdi_HmExteriorCdLu by HshldPrprtyCdi::HmHeatSrcCd left outer, HmHeatSrcCdLu by HmHeatSrcCd USING 'replicated';

join_HshldPrprtyCdi_HomeRoofTypeCdLu = join join_HshldPrprtyCdi_HmHeatSrcCdLu by HshldPrprtyCdi::HmRoofTypeCd left outer, HomeRoofTypeCdLu by HmRoofTypeCd USING 'replicated';

join_HshldCnsmrCdi_HshldPurchBhvrCdi = join join_HshldPrprtyCdi_HomeRoofTypeCdLu by CnsmrHshldCdi::HshldId left outer, HshldPurchBhvrCdi by HshldId;

--join_HshldCnsmrCdi_RaceCdLu = join join_HshldCnsmrCdi_HshldPurchBhvrCdi by HshldCnsmrCdi::RaceCd left outer, RaceCdLu by RaceCd USING 'replicated'; --Removed this logic to query the HshldNonBuyrOthrCdi table for race code

join_HshldNonBuyrOthrCdi_RaceCdLu = join join_HshldCnsmrCdi_HshldPurchBhvrCdi by HshldNonBuyrOthrCdi::LowDtlRaceCd left outer, RaceCdLu by RaceCd USING 'replicated';

join_HshldCnsmrCdi_EduLvlCdLu = join join_HshldNonBuyrOthrCdi_RaceCdLu by HshldCnsmrCdi::EduCd left outer, EduLvlCdLu by EduLvlCd USING 'replicated';

join_HshldCnsmrCdi_OccupCdLu = join join_HshldCnsmrCdi_EduLvlCdLu by HshldCnsmrCdi::OccupCd left outer, OccupCdLu by OccupCd USING 'replicated';

join_HshldCnsmrCdi_VotrPartyCdLu = join join_HshldCnsmrCdi_OccupCdLu by HshldCnsmrCdi::VotrPartyCd left outer, VotrPartyCdLu by VotrPartyCd USING 'replicated';

join_HshldNonBuyrOthrCdi_LifeEvntNewParCdLu = join join_HshldCnsmrCdi_VotrPartyCdLu by HshldNonBuyrOthrCdi::LifeEvntNewParCd left outer, LifeEvntNewParCdLu by LifeEvntNewParCd USING 'replicated';



CDI_ATTRIBUTES = FOREACH join_HshldNonBuyrOthrCdi_LifeEvntNewParCdLu GENERATE 
CnsmrLyltySywrSrcCdi::LyltyCardNbr
,org.sears.analytics.ValidateDate(HshldCnsmrCdi::BirthDt)
,GenderCdLu::GenderCdDesc
,PropTypeCdLu::PropTypeCdDesc
,LotSizeCdLu::LotSizeCdDesc
,HmOwnerRentrCdLu::HmOwnerRentrCdDesc
,YrAtResCdLu::YrAtResCdDesc
,HshldPremrPlusCdi::MrtlStatDesc
,AgeLu::AgeDesc
,AddrCdi::TotAddress
,EstIncmCdLu::EstIncmCdDesc
,HmMrktValuDciCdLu::HmMrktValuDciCdDesc
,HshldPrprtyCdi::HmConstrYrNbr
,Hshld_Geocd::LatDegQty
,Hshld_Geocd::LongtdDegQty
,Hshld_Geocd::LatRdnQty
,Hshld_Geocd::LongtRdnQty
,OccupntCntCdLu::OccupntCntCdDesc
,HshldPremrPlusCdi::ChildMale0to2Ind
,HshldPremrPlusCdi::ChildMale3to5Ind
,HshldPremrPlusCdi::ChildMale6to10Ind
,HshldPremrPlusCdi::ChildMale11to15Ind
,HshldPremrPlusCdi::ChildMale16to17Ind
,HshldPremrPlusCdi::ChildFem0to2Ind
,HshldPremrPlusCdi::ChildFem3to5Ind
,HshldPremrPlusCdi::ChildFem6to10Ind
,HshldPremrPlusCdi::ChildFem11to15Ind
,HshldPremrPlusCdi::ChildFem16to17Ind
,HshldLftrtsCdi::HobbCrftsInd
,HshldLftrtsCdi::HobbPhotoInd
,HshldLftrtsCdi::HobbAvtnInd
,HshldLftrtsCdi::HobbAutoMchncInd
,HshldLftrtsCdi::HobbSewKntwNdlwkInd
,HshldLftrtsCdi::HobbWdwrkInd
,HshldLftrtsCdi::HobbBoardGamPzzlInd
,VehCntCdLu::VehCntCdDesc
,HshldMotrVhclCdi::TruckOwnerInd
,HshldMotrVhclCdi::MtrcyOwnerInd
,HshldMotrVhclCdi::RvOwnerInd
,HshldLftrtsCdi::HmCmptrOwnerInd
,HshldLftrtsCdi::HmCmptrInetOnlineServInd
,HshldLftrtsCdi::HmCmptrPlayCmptrGamInd
,HshldHighTechCdi::ComptrPltfmCd
,OperSysCdLu::OperSysCdDesc
,HshldNonBuyrOthrCdi::LifeEvntCollgGradnInd
,HshldNonBuyrOthrCdi::LifeEvntEmptyNestrInd
,HshldNonBuyrOthrCdi::LifeEvntEntrAdulthdInd
,HshldNonBuyrOthrCdi::LifeEvntExpectParInd
,HshldNonBuyrOthrCdi::LifeEvntVhclPurchIntentInd
,HshldNonBuyrOthrCdi::LifeEvntNewlywedInd
,HshldNonBuyrOthrCdi::LifeEvntRcntDvcInd
,HshldNonBuyrOthrCdi::LifeEvntChildNrHsGradtnInd
,HshldNonBuyrOthrCdi::LifeEvntRcntHmBuyerInd
,HshldNonBuyrOthrCdi::LifeEvntRcntMortBrrwrInd
,HshldNonBuyrOthrCdi::LifeEvntNewMoveInd
,HshldNonBuyrOthrCdi::LifeEvntNewParCd
,HshldLftrtsCdi::PartcpSprtTennsInd
,HshldLftrtsCdi::PartcpSprtGolfInd
,HshldLftrtsCdi::PartcpSprtSnowSkngInd
,HshldLftrtsCdi::PartcpSprtMtrcyInd
,HshldLftrtsCdi::PartcpSprtEqstrianInd
,HshldLftrtsCdi::SpctrSprtAutoCycleRaceInd
,HshldLftrtsCdi::SpctrSprtFtbInd
,HshldLftrtsCdi::SpctrSprtBsbInd
,HshldLftrtsCdi::SpctrSprtBskInd
,HshldLftrtsCdi::SpctrSprtHkyInd
,HshldLftrtsCdi::SpctrSprtSoccerInd
,HshldLftrtsCdi::SpctrSprtTnnsInd
,HshldPurchBhvrCdi::DonteRlgnCauseInd
,HshldPurchBhvrCdi::DonteVtranCauseInd
,HshldPurchBhvrCdi::DonteChrtablCauseInd
,HshldLftrtsCdi::FamlyDogOwnerInd
,HshldLftrtsCdi::FamlyCatOwnerInd
,HshldLftrtsCdi::FamlyOtherPetOwnerInd
,HmEqtyAvailRngCdLu::HmEqtyAvailRngCdDesc
,HmSqftgCdLu::HmSqftgCdDesc
,HshldLftrtsCdi::ElecClulrPhoneOwnerInd
,HshldPurchBhvrCdi::CrCardUserInd
,HshldPurchBhvrCdi::DontePolCauseInd
,HshldPurchBhvrCdi::DonteConsrvtvCauseInd
,HshldPurchBhvrCdi::DonteLibrlCauseInd
,HshldPurchBhvrCdi::DonteAnimlWelfareInd
,HshldPurchBhvrCdi::DonteArtOrCltrlInd
,HshldPurchBhvrCdi::DonteChildCauseInd
,HshldPurchBhvrCdi::DonteEnvirOrWldlfInd
,HshldPurchBhvrCdi::DonteHlthCauseInd
,HshldPurchBhvrCdi::DonteIntlAidInd
,HshldPurchBhvrCdi::DonteOtherCauseInd
,HshldLfstlCdi::DiyInd
,HshldLftrtsCdi::ElecCnsmrElecInd
,HshldLftrtsCdi::ExerAerbcCrvscInd
,HshldLftrtsCdi::ExerRunJoggngInd
,HshldLftrtsCdi::ExerWalkInd
,HshldLftrtsCdi::FamlyChildIntInd
,HshldLftrtsCdi::FamlyGchInd
,HmExteriorCdLu::HmExteriorCdDesc
,HmHeatSrcCdLu::HmHeatSrcCdDesc
,HomeRoofTypeCdLu::HmRoofTypeCdDesc
,HshldPrprtyCdi::HmRoomQty
,HshldPrprtyCdi::SwimPoolInd
,RaceCdLu::RaceCdDesc
,EduLvlCdLu::EduLvlCdDesc
,OccupCdLu::OccupCdDesc
,VotrPartyCdLu::VotrPartyCdDesc
,LifeEvntNewParCdLu::LifeEvntNewParCdDesc
,CnsmrAddrCdi::MoveInDate;

STORE CDI_ATTRIBUTES into '$MADE_WORK_DIR/cdi/cdi_transformed' using PigStorage('\t');

