
Inferred_Input = LOAD '/warehouse/map_repo/work/InferredInternal/Segments/20150325' using PigStorage('\\u0001') as
(
download_temp :chararray,
LyltyCardNbr :chararray,
MthNbr :chararray,
ChgDt :chararray,
AssocInd :chararray,
CraftmanInd :chararray,
FastTrkInd :chararray,
HispanicInd :chararray,
KmtBabyInd :chararray,
KmtFashInd :chararray,
KmtGameInd :chararray,
KmtGardenInd :chararray,
KmtHlthWellnessInd :chararray,
KmtKidsInd :chararray,
KmtPetsInd :chararray,
SrsBabyInd :chararray,
SrsFashInd :chararray,
SrsGameInd :chararray,
SrsHlthWellnessInd :chararray,
SrsKidsInd :chararray,
SwstkInd :chararray,
VtranInd :chararray,
VIPInd :chararray,
FourPlusTripsInd :chararray,
AssocIndLY :chararray,
CraftmanIndLY :chararray,
FastTrkIndLY :chararray,
HispanicIndLY :chararray,
KmtBabyIndLY :chararray,
KmtFashIndLY :chararray,
KmtGameIndLY :chararray,
KmtGardenIndLY :chararray,
KmtHlthWellnessIndLY :chararray,
KmtKidsIndLY :chararray,
KmtPetsIndLY :chararray,
SrsBabyIndLY :chararray,
SrsFashIndLY :chararray,
SrsGameIndLY :chararray,
SrsHlthWellnessIndLY :chararray,
SrsKidsIndLY :chararray,
SwstkIndLY :chararray,
VtranIndLY :chararray,
VIPIndLY :chararray,
FourPlusTripsIndLY :chararray,
PersShopInd :chararray,
PersShopIndLY :chararray,
PersShopClientInd :chararray,
PersShopClientIndLY :chararray,
VAPPRRDonllyIndTY :chararray,
VAPPRRDonllyIndLY :chararray,
MovIndTY :chararray,
MovIndLY :chararray,
PreMovIndTY :chararray,
PreMovIndLY :chararray,
PostMovIndTY :chararray,
PostMovIndLY :chararray,
VAPPAttIndTY :chararray,
VAPPAttIndLY :chararray,
EliteIndTY :chararray,
SweepsWinIndTY :chararray,
EliteIndLY :chararray,
SweepsWinIndLY :chararray,
VAPPInfyIndTY :chararray,
VAPPInfyIndLY :chararray,
FamlyIndTY :chararray,
FamlyIndLY :chararray,
KmtMTAIndTY :chararray,
KmtMTAIndLY :chararray,
SrsMTAIndTY :chararray,
SrsMTAIndLY :chararray,
KmtDiabetesIndTY :chararray,
KmtDiabetesIndLY :chararray,
VAPPSiemensIndTY :chararray,
VAPPSiemensIndLY :chararray,
VAPPHavasIndTY :chararray,
VAPPHavasIndLY :chararray,
VAPPHPIndTY :chararray,
VAPPHPIndLY :chararray,
VAPPQGraphicsIndTY :chararray,
VAPPQGraphicsIndLY :chararray,
Sr65PlusIndTY :chararray,
Sr65PlusIndLY :chararray,
VAPPEpsilonIndTY :chararray,
VAPPWMIndTY :chararray,
VAPPUPMKymIndTY :chararray,
VAPPRandstadIndTY :chararray,
VAPPVersoPaperIndTY :chararray,
VAPPWWGrhgIndTY :chararray,
VAPPLeggPlatIndTY :chararray,
VAPPLGElecIndTY :chararray,
VAPPJacobsEngIndTY :chararray,
VAPPARIIndTY :chararray,
VAPPCDWIndTY :chararray,
VAPPFordIndTY :chararray,
VAPPOracleIndTY :chararray,
VAPPOsramSylIndTY :chararray,
VAPPAllianceMatIndTY :chararray,
VAPPEcovaIndTY :chararray,
VAPPElectroluxIndTY :chararray,
VAPPJohnsonCntlIndTY :chararray,
VAPPMcGerryIndTY :chararray,
VAPPReynoldsIndTY :chararray,
VAPPSprintIndTY :chararray,
VAPPWhirlIndTY :chararray,
VAPPEpsilonIndLY :chararray,
VAPPWMIndLY :chararray,
VAPPUPMKymIndLY :chararray,
VAPPRandstadIndLY :chararray,
VAPPVersoPaperIndLY :chararray,
VAPPWWGrhgIndLY :chararray,
VAPPLeggPlatIndLY :chararray,
VAPPLGElecIndLY :chararray,
VAPPJacobsEngIndLY :chararray,
VAPPARIIndLY :chararray,
VAPPCDWIndLY :chararray,
VAPPFordIndLY :chararray,
VAPPOracleIndLY :chararray,
VAPPOsramSylIndLY :chararray,
VAPPAllianceMatIndLY :chararray,
VAPPEcovaIndLY :chararray,
VAPPElectroluxIndLY :chararray,
VAPPJohnsonCntlIndLY :chararray,
VAPPMcGerryIndLY :chararray,
VAPPReynoldsIndLY :chararray,
VAPPSprintIndLY :chararray,
VAPPWhirlIndLY :chararray,
CashCheckIndTY :chararray,
CashCheckIndLY :chararray,
SwstkRpeatPlayIndTY :chararray,
SwstkRpeatPlayIndLY:chararray,
VAPPWiProIndTY:chararray,
VAPPWiProIndLY:chararray,
VAPPKbsServIndTY:chararray,
VAPPKbsServIndLY:chararray,
VAPPMDXGrpIndTY:chararray,
VAPPMDXGrpIndLY:chararray,
VAPPValvolineIndTY:chararray,
VAPPValvolineIndLY:chararray,
VAPPUSSecuritiesIndTY:chararray,
VAPPUSSecuritiesIndLY:chararray,
VAPPFideltoneIndTY:chararray,
VAPPFideltoneIndLY:chararray,
VAPPTelgianCorpIndTY:chararray,
VAPPTelgianCorpIndLY:chararray,
VAPPNCRIndTY:chararray,
VAPPNCRIndLY:chararray,
VAPPGannetIndTY:chararray,
VAPPGannetIndLY:chararray,
VAPPGencoIndTY:chararray,
VAPPGencoIndLY:chararray
);
----------------------

ShcLocn = LOAD 'hdfs://heahadn01.hadoop.searshc.com:8020/work/syw_member_repo/Inferred_internal/ShcLocn/' using PigStorage('\u0001') AS (createTs:chararray
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

sywprimarystore = LOAD 'hdfs://heahadn01.hadoop.searshc.com:8020/smith/map/sywr_primary_store_new/' using PigStorage('\u0001') AS (datacreationts:chararray, 
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
,(INT) flsprimarystore
,(INT) kmtprimarystore;

PrimaryStoreSearsJoin = JOIN sywprimarystore_req BY flsprimarystore LEFT OUTER, ShcLocn_Open BY OrigFacilNbr;
PrimaryStoreKmartJoin = JOIN sywprimarystore_req BY kmtprimarystore LEFT OUTER, ShcLocn_Open BY LocnNbr;

PrimaryStoreSears = FOREACH PrimaryStoreSearsJoin GENERATE sywprimarystore_req::lyltycardnbr as lyltycardnbr
,StringConcat(ShcLocn_Open::OrigFacilNbr, '-', ShcLocn_Open::LocnNm) as srs_primary_store;


PrimaryStoreKmart = FOREACH PrimaryStoreKmartJoin GENERATE sywprimarystore_req::lyltycardnbr as lyltycardnbr
,StringConcat(ShcLocn_Open::LocnNbr, '-', ShcLocn_Open::LocnNm) as kmt_primary_store;

join_srs_kmt_store = JOIN PrimaryStoreSears BY lyltycardnbr, PrimaryStoreKmart BY lyltycardnbr;

foreach_srs_kmt_store = FOREACH join_srs_kmt_store GENERATE
PrimaryStoreSears::lyltycardnbr as lyltycardnbr, PrimaryStoreSears::srs_primary_store as srs_primary_store,
PrimaryStoreKmart::kmt_primary_store as kmt_primary_store;

---------------------
inferred_transform = FILTER Inferred_Input BY LyltyCardNbr IS NOT NULL;
final_inferred = FOREACH inferred_transform GENERATE
LyltyCardNbr
,(CASE WHEN KmtBabyInd is null  THEN 'NO' WHEN KmtBabyInd == '1' THEN 'YES' ELSE 'NO' END) as KmtBabyInd 
,(CASE WHEN KmtFashInd is null  THEN 'NO' WHEN KmtFashInd == '1' THEN 'YES' ELSE 'NO' END) as KmtFashInd 
,(CASE WHEN KmtGameInd is null  THEN 'NO' WHEN KmtGameInd == '1' THEN 'YES' ELSE 'NO' END) as KmtGameInd 
,(CASE WHEN KmtGardenInd is null  THEN 'NO' WHEN KmtGardenInd == '1' THEN 'YES' ELSE 'NO' END) as KmtGardenInd 
,(CASE WHEN KmtHlthWellnessInd is null  THEN 'NO' WHEN KmtHlthWellnessInd == '1' THEN 'YES' ELSE 'NO' END) as KmtHlthWellnessInd 
,(CASE WHEN KmtKidsInd is null  THEN 'NO' WHEN KmtKidsInd == '1' THEN 'YES' ELSE 'NO' END) as KmtKidsInd 
,(CASE WHEN KmtPetsInd is null  THEN 'NO' WHEN KmtPetsInd == '1' THEN 'YES' ELSE 'NO' END) as KmtPetsInd 
,(CASE WHEN SrsBabyInd is null  THEN 'NO' WHEN SrsBabyInd == '1' THEN 'YES' ELSE 'NO' END) as SrsBabyInd 
,(CASE WHEN SrsFashInd is null  THEN 'NO' WHEN SrsFashInd == '1' THEN 'YES' ELSE 'NO' END) as SrsFashInd 
,(CASE WHEN SrsGameInd is null  THEN 'NO' WHEN SrsGameInd == '1' THEN 'YES' ELSE 'NO' END) as SrsGameInd 
,(CASE WHEN SrsHlthWellnessInd is null  THEN 'NO' WHEN SrsHlthWellnessInd == '1' THEN 'YES' ELSE 'NO' END) as SrsHlthWellnessInd 
,(CASE WHEN SrsKidsInd is null  THEN 'NO' WHEN SrsKidsInd == '1' THEN 'YES' ELSE 'NO' END) as SrsKidsInd 
,(CASE WHEN SwstkInd is null  THEN 'NO' WHEN SwstkInd == '1' THEN 'YES' ELSE 'NO' END) as SwstkInd 
,(CASE WHEN VtranInd is null  THEN 'NO' WHEN VtranInd == '1' THEN 'YES' ELSE 'NO' END) as VtranInd 
,(CASE WHEN VIPInd is null  THEN 'NO' WHEN VIPInd == '1' THEN 'YES' ELSE 'NO' END) as VIPInd 
,(CASE WHEN FourPlusTripsInd is null  THEN 'NO' WHEN FourPlusTripsInd == '1' THEN 'YES' ELSE 'NO' END) as FourPlusTripsInd 
,(CASE WHEN PersShopInd is null  THEN 'NO' WHEN PersShopInd == '1' THEN 'YES' ELSE 'NO' END) as PersShopInd 
,(CASE WHEN PersShopClientInd is null  THEN 'NO' WHEN PersShopClientInd == '1' THEN 'YES' ELSE 'NO' END) as PersShopClientInd 
,(CASE WHEN VAPPRRDonllyIndTY is null  THEN 'NO' WHEN VAPPRRDonllyIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPRRDonllyIndTY 
,(CASE WHEN PreMovIndTY is null  THEN 'NO' WHEN PreMovIndTY == '1' THEN 'YES' ELSE 'NO' END) as PreMovIndTY 
,(CASE WHEN PostMovIndTY is null  THEN 'NO' WHEN PostMovIndTY == '1' THEN 'YES' ELSE 'NO' END) as PostMovIndTY 
,(CASE WHEN VAPPAttIndTY is null  THEN 'NO' WHEN VAPPAttIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPAttIndTY 
,(CASE WHEN EliteIndTY is null  THEN 'NO' WHEN EliteIndTY == '1' THEN 'YES' ELSE 'NO' END) as EliteIndTY 
,(CASE WHEN SweepsWinIndTY is null  THEN 'NO' WHEN SweepsWinIndTY == '1' THEN 'YES' ELSE 'NO' END) as SweepsWinIndTY 
,(CASE WHEN VAPPInfyIndTY is null  THEN 'NO' WHEN VAPPInfyIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPInfyIndTY 
,(CASE WHEN FamlyIndTY is null  THEN 'NO' WHEN FamlyIndTY == '1' THEN 'YES' ELSE 'NO' END) as FamlyIndTY 
,(CASE WHEN KmtMTAIndTY is null  THEN 'NO' WHEN KmtMTAIndTY == '1' THEN 'YES' ELSE 'NO' END) as KmtMTAIndTY 
,(CASE WHEN SrsMTAIndTY is null  THEN 'NO' WHEN SrsMTAIndTY == '1' THEN 'YES' ELSE 'NO' END) as SrsMTAIndTY 
,(CASE WHEN KmtDiabetesIndTY is null  THEN 'NO' WHEN KmtDiabetesIndTY == '1' THEN 'YES' ELSE 'NO' END) as KmtDiabetesIndTY 
,(CASE WHEN VAPPSiemensIndTY is null  THEN 'NO' WHEN VAPPSiemensIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPSiemensIndTY 
,(CASE WHEN VAPPHavasIndTY is null  THEN 'NO' WHEN VAPPHavasIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPHavasIndTY 
,(CASE WHEN VAPPHPIndTY is null  THEN 'NO' WHEN VAPPHPIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPHPIndTY 
,(CASE WHEN VAPPQGraphicsIndTY is null  THEN 'NO' WHEN VAPPQGraphicsIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPQGraphicsIndTY 
,(CASE WHEN Sr65PlusIndTY is null  THEN 'NO' WHEN Sr65PlusIndTY == '1' THEN 'YES' ELSE 'NO' END) as Sr65PlusIndTY 
,(CASE WHEN VAPPEpsilonIndTY is null  THEN 'NO' WHEN VAPPEpsilonIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPEpsilonIndTY 
,(CASE WHEN VAPPWMIndTY is null  THEN 'NO' WHEN VAPPWMIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPWMIndTY 
,(CASE WHEN VAPPUPMKymIndTY is null  THEN 'NO' WHEN VAPPUPMKymIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPUPMKymIndTY 
,(CASE WHEN VAPPRandstadIndTY is null  THEN 'NO' WHEN VAPPRandstadIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPRandstadIndTY 
,(CASE WHEN VAPPVersoPaperIndTY is null  THEN 'NO' WHEN VAPPVersoPaperIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPVersoPaperIndTY 
,(CASE WHEN VAPPWWGrhgIndTY is null  THEN 'NO' WHEN VAPPWWGrhgIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPWWGrhgIndTY 
,(CASE WHEN VAPPLeggPlatIndTY is null  THEN 'NO' WHEN VAPPLeggPlatIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPLeggPlatIndTY 
,(CASE WHEN VAPPLGElecIndTY is null  THEN 'NO' WHEN VAPPLGElecIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPLGElecIndTY 
,(CASE WHEN VAPPJacobsEngIndTY is null  THEN 'NO' WHEN VAPPJacobsEngIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPJacobsEngIndTY 
,(CASE WHEN VAPPARIIndTY is null  THEN 'NO' WHEN VAPPARIIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPARIIndTY 
,(CASE WHEN VAPPCDWIndTY is null  THEN 'NO' WHEN VAPPCDWIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPCDWIndTY 
,(CASE WHEN VAPPFordIndTY is null  THEN 'NO' WHEN VAPPFordIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPFordIndTY 
,(CASE WHEN VAPPOracleIndTY is null  THEN 'NO' WHEN VAPPOracleIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPOracleIndTY 
,(CASE WHEN VAPPOsramSylIndTY is null  THEN 'NO' WHEN VAPPOsramSylIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPOsramSylIndTY 
,(CASE WHEN VAPPAllianceMatIndTY is null  THEN 'NO' WHEN VAPPAllianceMatIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPAllianceMatIndTY 
,(CASE WHEN VAPPEcovaIndTY is null  THEN 'NO' WHEN VAPPEcovaIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPEcovaIndTY 
,(CASE WHEN VAPPElectroluxIndTY is null  THEN 'NO' WHEN VAPPElectroluxIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPElectroluxIndTY 
,(CASE WHEN VAPPJohnsonCntlIndTY is null  THEN 'NO' WHEN VAPPJohnsonCntlIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPJohnsonCntlIndTY 
,(CASE WHEN VAPPMcGerryIndTY is null  THEN 'NO' WHEN VAPPMcGerryIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPMcGerryIndTY 
,(CASE WHEN VAPPReynoldsIndTY is null  THEN 'NO' WHEN VAPPReynoldsIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPReynoldsIndTY 
,(CASE WHEN VAPPSprintIndTY is null  THEN 'NO' WHEN VAPPSprintIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPSprintIndTY 
,(CASE WHEN VAPPWhirlIndTY is null  THEN 'NO' WHEN VAPPWhirlIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPWhirlIndTY 
,(CASE WHEN FastTrkInd is null  THEN 'NO' WHEN FastTrkInd == '1' THEN 'YES' ELSE 'NO' END) as FastTrkInd 
,(CASE WHEN HispanicInd is null  THEN 'NO' WHEN HispanicInd == '1' THEN 'YES' ELSE 'NO' END) as HispanicInd 
,(CASE WHEN MovIndTY is null  THEN 'NO' WHEN MovIndTY == '1' THEN 'YES' ELSE 'NO' END) as MovIndTY 
,(CASE WHEN CashCheckIndTY is null  THEN 'NO' WHEN CashCheckIndTY == '1' THEN 'YES' ELSE 'NO' END) as CashCheckIndTY 
,(CASE WHEN SwstkRpeatPlayIndTY is null  THEN 'NO' WHEN SwstkRpeatPlayIndTY == '1' THEN 'YES' ELSE 'NO' END) as SwstkRpeatPlayIndTY 
,(CASE WHEN VAPPWiProIndTY is null  THEN 'NO' WHEN VAPPWiProIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPWiProIndTY 
,(CASE WHEN VAPPKbsServIndTY is null  THEN 'NO' WHEN VAPPKbsServIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPKbsServIndTY 
,(CASE WHEN VAPPMDXGrpIndTY is null  THEN 'NO' WHEN VAPPMDXGrpIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPMDXGrpIndTY 
,(CASE WHEN VAPPValvolineIndTY is null  THEN 'NO' WHEN VAPPValvolineIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPValvolineIndTY 
,(CASE WHEN VAPPUSSecuritiesIndTY is null  THEN 'NO' WHEN VAPPUSSecuritiesIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPUSSecuritiesIndTY 
,(CASE WHEN VAPPFideltoneIndTY is null  THEN 'NO' WHEN VAPPFideltoneIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPFideltoneIndTY 
,(CASE WHEN VAPPTelgianCorpIndTY is null  THEN 'NO' WHEN VAPPTelgianCorpIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPTelgianCorpIndTY 
,(CASE WHEN VAPPNCRIndTY is null  THEN 'NO' WHEN VAPPNCRIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPNCRIndTY 
,(CASE WHEN VAPPGannetIndTY is null  THEN 'NO' WHEN VAPPGannetIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPGannetIndTY 
,(CASE WHEN VAPPGencoIndTY is null  THEN 'NO' WHEN VAPPGencoIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPGencoIndTY;
----------------------------

final_join = join foreach_srs_kmt_store BY lyltycardnbr FULL, final_inferred BY LyltyCardNbr;

foreach_join = FOREACH final_join GENERATE
(CASE WHEN final_inferred::LyltyCardNbr IS NULL THEN foreach_srs_kmt_store::lyltycardnbr ELSE final_inferred::LyltyCardNbr END) as lyltycardnbr
,final_inferred::KmtBabyInd 
,final_inferred::KmtFashInd 
,final_inferred::KmtGameInd 
,final_inferred::KmtGardenInd 
,final_inferred::KmtHlthWellnessInd 
,final_inferred::KmtKidsInd 
,final_inferred::KmtPetsInd 
,final_inferred::SrsBabyInd 
,final_inferred::SrsFashInd 
,final_inferred::SrsGameInd 
,final_inferred::SrsHlthWellnessInd 
,final_inferred::SrsKidsInd 
,final_inferred::SwstkInd 
,final_inferred::VtranInd 
,final_inferred::VIPInd 
,final_inferred::FourPlusTripsInd 
,final_inferred::PersShopInd 
,final_inferred::PersShopClientInd 
,final_inferred::VAPPRRDonllyIndTY 
,final_inferred::PreMovIndTY 
,final_inferred::PostMovIndTY 
,final_inferred::VAPPAttIndTY 
,final_inferred::EliteIndTY 
,final_inferred::SweepsWinIndTY 
,final_inferred::VAPPInfyIndTY 
,final_inferred::FamlyIndTY 
,final_inferred::KmtMTAIndTY 
,final_inferred::SrsMTAIndTY 
,final_inferred::KmtDiabetesIndTY 
,final_inferred::VAPPSiemensIndTY 
,final_inferred::VAPPHavasIndTY 
,final_inferred::VAPPHPIndTY 
,final_inferred::VAPPQGraphicsIndTY 
,final_inferred::Sr65PlusIndTY 
,final_inferred::VAPPEpsilonIndTY 
,final_inferred::VAPPWMIndTY 
,final_inferred::VAPPUPMKymIndTY 
,final_inferred::VAPPRandstadIndTY 
,final_inferred::VAPPVersoPaperIndTY 
,final_inferred::VAPPWWGrhgIndTY 
,final_inferred::VAPPLeggPlatIndTY 
,final_inferred::VAPPLGElecIndTY 
,final_inferred::VAPPJacobsEngIndTY 
,final_inferred::VAPPARIIndTY 
,final_inferred::VAPPCDWIndTY 
,final_inferred::VAPPFordIndTY 
,final_inferred::VAPPOracleIndTY 
,final_inferred::VAPPOsramSylIndTY 
,final_inferred::VAPPAllianceMatIndTY 
,final_inferred::VAPPEcovaIndTY 
,final_inferred::VAPPElectroluxIndTY 
,final_inferred::VAPPJohnsonCntlIndTY 
,final_inferred::VAPPMcGerryIndTY 
,final_inferred::VAPPReynoldsIndTY 
,final_inferred::VAPPSprintIndTY 
,final_inferred::VAPPWhirlIndTY 
,final_inferred::FastTrkInd 
,final_inferred::HispanicInd 
,final_inferred::MovIndTY 
,final_inferred::CashCheckIndTY 
,final_inferred::SwstkRpeatPlayIndTY 
,final_inferred::VAPPWiProIndTY 
,final_inferred::VAPPKbsServIndTY 
,final_inferred::VAPPMDXGrpIndTY 
,final_inferred::VAPPValvolineIndTY 
,final_inferred::VAPPUSSecuritiesIndTY 
,final_inferred::VAPPFideltoneIndTY 
,final_inferred::VAPPTelgianCorpIndTY 
,final_inferred::VAPPNCRIndTY 
,final_inferred::VAPPGannetIndTY 
,final_inferred::VAPPGencoIndTY,
foreach_srs_kmt_store::srs_primary_store,
foreach_srs_kmt_store::kmt_primary_store;

STORE foreach_join into '/warehouse/made/work/InferredInternal/Segments/20150325' using PigStorage('\\u0001');

