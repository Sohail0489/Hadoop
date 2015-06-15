-------------------------------------------------------------------------------------------------------------
-- Sears Holding Corporation, 2015
-- Script       : made_inferred_Transformations.pig
-- Purpose      : Transform Inferred Internal attributes to be used for aggregated collection
--
--               Version Detail
--   Author      Version         Detail
--   smoham3       1.0           Concatinate Segments either into Vapp or syw_sements category if they are yes
--------------------------------------------------------------------------------------------------------------

Inferred_Input = LOAD '$MAP_PROD_DIR/inferred/ViSegMbrTyLyV3/current' using PigStorage('\u0001') as
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
---loading active member table

ActiveMember = LOAD '$MADE_WORK_DIR/telluride/ActiveMembership' AS (LyltyCardNbr:chararray);

----------------------
--joining inferred table with active members

inferred_active = join Inferred_Input BY LyltyCardNbr,ActiveMember BY LyltyCardNbr;
--------------------

final_inferred = FOREACH inferred_active GENERATE
Inferred_Input::LyltyCardNbr
,(CASE WHEN Inferred_Input::KmtBabyInd is null  THEN 'NO' WHEN Inferred_Input::KmtBabyInd == '1' THEN 'YES' ELSE 'NO' END) as KmtBabyInd 
,(CASE WHEN Inferred_Input::KmtFashInd is null  THEN 'NO' WHEN Inferred_Input::KmtFashInd == '1' THEN 'YES' ELSE 'NO' END) as KmtFashInd 
,(CASE WHEN Inferred_Input::KmtGameInd is null  THEN 'NO' WHEN Inferred_Input::KmtGameInd == '1' THEN 'YES' ELSE 'NO' END) as KmtGameInd 
,(CASE WHEN Inferred_Input::KmtGardenInd is null  THEN 'NO' WHEN Inferred_Input::KmtGardenInd == '1' THEN 'YES' ELSE 'NO' END) as KmtGardenInd 
,(CASE WHEN Inferred_Input::KmtHlthWellnessInd is null  THEN 'NO' WHEN Inferred_Input::KmtHlthWellnessInd == '1' THEN 'YES' ELSE 'NO' END) as KmtHlthWellnessInd 
,(CASE WHEN Inferred_Input::KmtKidsInd is null  THEN 'NO' WHEN Inferred_Input::KmtKidsInd == '1' THEN 'YES' ELSE 'NO' END) as KmtKidsInd 
,(CASE WHEN Inferred_Input::KmtPetsInd is null  THEN 'NO' WHEN Inferred_Input::KmtPetsInd == '1' THEN 'YES' ELSE 'NO' END) as KmtPetsInd 
,(CASE WHEN Inferred_Input::SrsBabyInd is null  THEN 'NO' WHEN Inferred_Input::SrsBabyInd == '1' THEN 'YES' ELSE 'NO' END) as SrsBabyInd 
,(CASE WHEN Inferred_Input::SrsFashInd is null  THEN 'NO' WHEN Inferred_Input::SrsFashInd == '1' THEN 'YES' ELSE 'NO' END) as SrsFashInd 
,(CASE WHEN Inferred_Input::SrsGameInd is null  THEN 'NO' WHEN Inferred_Input::SrsGameInd == '1' THEN 'YES' ELSE 'NO' END) as SrsGameInd 
,(CASE WHEN Inferred_Input::SrsHlthWellnessInd is null  THEN 'NO' WHEN Inferred_Input::SrsHlthWellnessInd == '1' THEN 'YES' ELSE 'NO' END) as SrsHlthWellnessInd 
,(CASE WHEN Inferred_Input::SrsKidsInd is null  THEN 'NO' WHEN Inferred_Input::SrsKidsInd == '1' THEN 'YES' ELSE 'NO' END) as SrsKidsInd 
,(CASE WHEN Inferred_Input::SwstkInd is null  THEN 'NO' WHEN Inferred_Input::SwstkInd == '1' THEN 'YES' ELSE 'NO' END) as SwstkInd 
,(CASE WHEN Inferred_Input::VtranInd is null  THEN 'NO' WHEN Inferred_Input::VtranInd == '1' THEN 'YES' ELSE 'NO' END) as VtranInd 
,(CASE WHEN Inferred_Input::VIPInd is null  THEN 'NO' WHEN Inferred_Input::VIPInd == '1' THEN 'YES' ELSE 'NO' END) as VIPInd 
,(CASE WHEN Inferred_Input::FourPlusTripsInd is null  THEN 'NO' WHEN Inferred_Input::FourPlusTripsInd == '1' THEN 'YES' ELSE 'NO' END) as FourPlusTripsInd 
,(CASE WHEN Inferred_Input::PersShopInd is null  THEN 'NO' WHEN Inferred_Input::PersShopInd == '1' THEN 'YES' ELSE 'NO' END) as PersShopInd 
,(CASE WHEN Inferred_Input::PersShopClientInd is null  THEN 'NO' WHEN Inferred_Input::PersShopClientInd == '1' THEN 'YES' ELSE 'NO' END) as PersShopClientInd 
,(CASE WHEN Inferred_Input::VAPPRRDonllyIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPRRDonllyIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPRRDonllyIndTY 
,(CASE WHEN Inferred_Input::PreMovIndTY is null  THEN 'NO' WHEN Inferred_Input::PreMovIndTY == '1' THEN 'YES' ELSE 'NO' END) as PreMovIndTY 
,(CASE WHEN Inferred_Input::PostMovIndTY is null  THEN 'NO' WHEN Inferred_Input::PostMovIndTY == '1' THEN 'YES' ELSE 'NO' END) as PostMovIndTY 
,(CASE WHEN Inferred_Input::VAPPAttIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPAttIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPAttIndTY 
,(CASE WHEN Inferred_Input::EliteIndTY is null  THEN 'NO' WHEN Inferred_Input::EliteIndTY == '1' THEN 'YES' ELSE 'NO' END) as EliteIndTY 
,(CASE WHEN Inferred_Input::SweepsWinIndTY is null  THEN 'NO' WHEN Inferred_Input::SweepsWinIndTY == '1' THEN 'YES' ELSE 'NO' END) as SweepsWinIndTY 
,(CASE WHEN Inferred_Input::VAPPInfyIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPInfyIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPInfyIndTY 
,(CASE WHEN Inferred_Input::FamlyIndTY is null  THEN 'NO' WHEN Inferred_Input::FamlyIndTY == '1' THEN 'YES' ELSE 'NO' END) as FamlyIndTY 
,(CASE WHEN Inferred_Input::KmtMTAIndTY is null  THEN 'NO' WHEN Inferred_Input::KmtMTAIndTY == '1' THEN 'YES' ELSE 'NO' END) as KmtMTAIndTY 
,(CASE WHEN Inferred_Input::SrsMTAIndTY is null  THEN 'NO' WHEN Inferred_Input::SrsMTAIndTY == '1' THEN 'YES' ELSE 'NO' END) as SrsMTAIndTY 
,(CASE WHEN Inferred_Input::KmtDiabetesIndTY is null  THEN 'NO' WHEN Inferred_Input::KmtDiabetesIndTY == '1' THEN 'YES' ELSE 'NO' END) as KmtDiabetesIndTY 
,(CASE WHEN Inferred_Input::VAPPSiemensIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPSiemensIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPSiemensIndTY 
,(CASE WHEN Inferred_Input::VAPPHavasIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPHavasIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPHavasIndTY 
,(CASE WHEN Inferred_Input::VAPPHPIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPHPIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPHPIndTY 
,(CASE WHEN Inferred_Input::VAPPQGraphicsIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPQGraphicsIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPQGraphicsIndTY 
,(CASE WHEN Inferred_Input::Sr65PlusIndTY is null  THEN 'NO' WHEN Inferred_Input::Sr65PlusIndTY == '1' THEN 'YES' ELSE 'NO' END) as Sr65PlusIndTY 
,(CASE WHEN Inferred_Input::VAPPEpsilonIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPEpsilonIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPEpsilonIndTY 
,(CASE WHEN Inferred_Input::VAPPWMIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPWMIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPWMIndTY 
,(CASE WHEN Inferred_Input::VAPPUPMKymIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPUPMKymIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPUPMKymIndTY 
,(CASE WHEN Inferred_Input::VAPPRandstadIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPRandstadIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPRandstadIndTY 
,(CASE WHEN Inferred_Input::VAPPVersoPaperIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPVersoPaperIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPVersoPaperIndTY 
,(CASE WHEN Inferred_Input::VAPPWWGrhgIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPWWGrhgIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPWWGrhgIndTY 
,(CASE WHEN Inferred_Input::VAPPLeggPlatIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPLeggPlatIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPLeggPlatIndTY 
,(CASE WHEN Inferred_Input::VAPPLGElecIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPLGElecIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPLGElecIndTY 
,(CASE WHEN Inferred_Input::VAPPJacobsEngIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPJacobsEngIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPJacobsEngIndTY 
,(CASE WHEN Inferred_Input::VAPPARIIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPARIIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPARIIndTY 
,(CASE WHEN Inferred_Input::VAPPCDWIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPCDWIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPCDWIndTY 
,(CASE WHEN Inferred_Input::VAPPFordIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPFordIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPFordIndTY 
,(CASE WHEN Inferred_Input::VAPPOracleIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPOracleIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPOracleIndTY 
,(CASE WHEN Inferred_Input::VAPPOsramSylIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPOsramSylIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPOsramSylIndTY 
,(CASE WHEN Inferred_Input::VAPPAllianceMatIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPAllianceMatIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPAllianceMatIndTY 
,(CASE WHEN Inferred_Input::VAPPEcovaIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPEcovaIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPEcovaIndTY 
,(CASE WHEN Inferred_Input::VAPPElectroluxIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPElectroluxIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPElectroluxIndTY 
,(CASE WHEN Inferred_Input::VAPPJohnsonCntlIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPJohnsonCntlIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPJohnsonCntlIndTY 
,(CASE WHEN Inferred_Input::VAPPMcGerryIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPMcGerryIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPMcGerryIndTY 
,(CASE WHEN Inferred_Input::VAPPReynoldsIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPReynoldsIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPReynoldsIndTY 
,(CASE WHEN Inferred_Input::VAPPSprintIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPSprintIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPSprintIndTY 
,(CASE WHEN Inferred_Input::VAPPWhirlIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPWhirlIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPWhirlIndTY 
,(CASE WHEN Inferred_Input::FastTrkInd is null  THEN 'NO' WHEN Inferred_Input::FastTrkInd == '1' THEN 'YES' ELSE 'NO' END) as FastTrkInd 
,(CASE WHEN Inferred_Input::HispanicInd is null  THEN 'NO' WHEN Inferred_Input::HispanicInd == '1' THEN 'YES' ELSE 'NO' END) as HispanicInd 
,(CASE WHEN Inferred_Input::MovIndTY is null  THEN 'NO' WHEN Inferred_Input::MovIndTY == '1' THEN 'YES' ELSE 'NO' END) as MovIndTY 
,(CASE WHEN Inferred_Input::CashCheckIndTY is null  THEN 'NO' WHEN Inferred_Input::CashCheckIndTY == '1' THEN 'YES' ELSE 'NO' END) as CashCheckIndTY 
,(CASE WHEN Inferred_Input::SwstkRpeatPlayIndTY is null  THEN 'NO' WHEN Inferred_Input::SwstkRpeatPlayIndTY == '1' THEN 'YES' ELSE 'NO' END) as SwstkRpeatPlayIndTY 
,(CASE WHEN Inferred_Input::VAPPWiProIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPWiProIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPWiProIndTY 
,(CASE WHEN Inferred_Input::VAPPKbsServIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPKbsServIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPKbsServIndTY 
,(CASE WHEN Inferred_Input::VAPPMDXGrpIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPMDXGrpIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPMDXGrpIndTY 
,(CASE WHEN Inferred_Input::VAPPValvolineIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPValvolineIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPValvolineIndTY 
,(CASE WHEN Inferred_Input::VAPPUSSecuritiesIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPUSSecuritiesIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPUSSecuritiesIndTY 
,(CASE WHEN Inferred_Input::VAPPFideltoneIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPFideltoneIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPFideltoneIndTY 
,(CASE WHEN Inferred_Input::VAPPTelgianCorpIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPTelgianCorpIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPTelgianCorpIndTY 
,(CASE WHEN Inferred_Input::VAPPNCRIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPNCRIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPNCRIndTY 
,(CASE WHEN Inferred_Input::VAPPGannetIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPGannetIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPGannetIndTY 
,(CASE WHEN Inferred_Input::VAPPGencoIndTY is null  THEN 'NO' WHEN Inferred_Input::VAPPGencoIndTY == '1' THEN 'YES' ELSE 'NO' END) as VAPPGencoIndTY;

STORE final_inferred into '$MADE_WORK_DIR/inferred/inferred_transformed' using PigStorage('\u0001');
