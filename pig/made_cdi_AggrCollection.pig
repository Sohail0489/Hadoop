
REGISTER '$MADE_JAR_DIR/Search.jar';

load_CDI = load '$MADE_WORK_DIR/cdi/cdi_transformed' using PigStorage('\t') as
(
 LyltyCardNbr:chararray
,BirthDt:chararray
,GenderCdDesc:chararray
,PropTypeCdDesc:chararray
,LotSizeCdDesc:chararray
,HmOwnerRentrCdDesc:chararray
,YrAtResCdDesc:chararray
,MrtlStatDesc:chararray
,AgeDesc:chararray
,TotAddress:chararray
,EstIncmCdDesc:chararray
,HmMrktValuDciCdDesc:chararray
,HmConstrYrNbr:chararray
,LatDegQty:chararray
,LongtdDegQty:chararray
,LatRdnQty:chararray
,LongtRdnQty:chararray
,OccupntCntCdDesc:chararray
,ChildMale0to2Ind:chararray
,ChildMale3to5Ind:chararray
,ChildMale6to10Ind:chararray
,ChildMale11to15Ind:chararray
,ChildMale16to17Ind:chararray
,ChildFem0to2Ind:chararray
,ChildFem3to5Ind:chararray
,ChildFem6to10Ind:chararray
,ChildFem11to15Ind:chararray
,ChildFem16to17Ind:chararray
,HobbCrftsInd:chararray
,HobbPhotoInd:chararray
,HobbAvtnInd:chararray
,HobbAutoMchncInd:chararray
,HobbSewKntwNdlwkInd:chararray
,HobbWdwrkInd:chararray
,HobbBoardGamPzzlInd:chararray
,VehCntCdDesc:chararray
,TruckOwnerInd:chararray
,MtrcyOwnerInd:chararray
,RvOwnerInd:chararray
,HmCmptrOwnerInd:chararray
,HmCmptrInetOnlineServInd:chararray
,HmCmptrPlayCmptrGamInd:chararray
,ComptrPltfmCd:chararray
,OperSysCdDesc:chararray
,LifeEvntCollgGradnInd:chararray
,LifeEvntEmptyNestrInd:chararray
,LifeEvntEntrAdulthdInd:chararray
,LifeEvntExpectParInd:chararray
,LifeEvntVhclPurchIntentInd:chararray
,LifeEvntNewlywedInd:chararray
,LifeEvntRcntDvcInd:chararray
,LifeEvntChildNrHsGradtnInd:chararray
,LifeEvntRcntHmBuyerInd:chararray
,LifeEvntRcntMortBrrwrInd:chararray
,LifeEvntNewMoveInd:chararray
,LifeEvntNewParCd:chararray
,PartcpSprtTennsInd:chararray
,PartcpSprtGolfInd:chararray
,PartcpSprtSnowSkngInd:chararray
,PartcpSprtMtrcyInd:chararray
,PartcpSprtEqstrianInd:chararray
,SpctrSprtAutoCycleRaceInd:chararray
,SpctrSprtFtbInd:chararray
,SpctrSprtBsbInd:chararray
,SpctrSprtBskInd:chararray
,SpctrSprtHkyInd:chararray
,SpctrSprtSoccerInd:chararray
,SpctrSprtTnnsInd:chararray
,DonteRlgnCauseInd:chararray
,DonteVtranCauseInd:chararray
,DonteChrtablCauseInd:chararray
,FamlyDogOwnerInd:chararray
,FamlyCatOwnerInd:chararray
,FamlyOtherPetOwnerInd:chararray
,HmEqtyAvailRngCdDesc:chararray
,HmSqftgCdDesc:chararray
,ElecClulrPhoneOwnerInd:chararray
,CrCardUserInd:chararray
,DontePolCauseInd:chararray
,DonteConsrvtvCauseInd:chararray
,DonteLibrlCauseInd:chararray
,DonteAnimlWelfareInd:chararray
,DonteArtOrCltrlInd:chararray
,DonteChildCauseInd:chararray
,DonteEnvirOrWldlfInd:chararray
,DonteHlthCauseInd:chararray
,DonteIntlAidInd:chararray
,DonteOtherCauseInd:chararray
,DiyInd:chararray
,ElecCnsmrElecInd:chararray
,ExerAerbcCrvscInd:chararray
,ExerRunJoggngInd:chararray
,ExerWalkInd:chararray
,FamlyChildIntInd:chararray
,FamlyGchInd:chararray
,HmExteriorCdDesc:chararray
,HmHeatSrcCdDesc:chararray
,HmRoofTypeCdDesc:chararray
,HmRoomQty:chararray
,SwimPoolInd:chararray
,RaceCdDesc:chararray
,EduLvlCdDesc:chararray
,OccupCdDesc:chararray
,VotrPartyCdDesc:chararray
,LifeEvntNewParCdDesc:chararray
,MoveInDate:chararray
);

foreach_CDI = foreach load_CDI 
{
pettype =  org.sears.analytics.CDIPetType(FamlyDogOwnerInd,FamlyCatOwnerInd,FamlyOtherPetOwnerInd);
GENERATE
CONCAT(LyltyCardNbr,'3RD'),
'3RD',
LyltyCardNbr,
'',
'',
org.sears.analytics.SearchUTC(org.sears.analytics.ValidateDate(BirthDt)),
GenderCdDesc,
--RaceCdDesc,
(RaceCdDesc=='White'? 'Caucasian':(RaceCdDesc=='Black'? 'African American':(RaceCdDesc=='Asian'? 'Asian - Pacific Islander':RaceCdDesc))),
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
--pettype,
REPLACE(REPLACE(CONCAT(CONCAT(CONCAT(((FamlyDogOwnerInd is null?'':(FamlyDogOwnerInd==''?'':FamlyDogOwnerInd))=='Y'?'Dog~':' ~'),((FamlyCatOwnerInd is null?'':(FamlyCatOwnerInd==''?'':FamlyCatOwnerInd))=='Y'?'Cat~':' ~')),((FamlyOtherPetOwnerInd is null?'':(FamlyOtherPetOwnerInd==''?'':FamlyOtherPetOwnerInd))=='Y'?'Other Animal~':' ~')),' '),' ~',''),'~ ',''),
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
(VotrPartyCdDesc=='Voter - No Party' ? 'No Party' : (VotrPartyCdDesc=='Voter - Independent' ? 'Independent' : (VotrPartyCdDesc=='Voter - Democratic' ? 'Democrat' : (VotrPartyCdDesc=='Voter - Republican' ? 'Republican' :VotrPartyCdDesc)))) as VotrPartyCdDesc, 
'',
'',
'',
'',
'',
'',
'',
LotSizeCdDesc,
'',
(HmOwnerRentrCdDesc == 'Home Owner' ? 'Own' : (HmOwnerRentrCdDesc == 'Renter' ? 'Rent' : HmOwnerRentrCdDesc)) as HmOwnerRentrCdDesc,
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
(MrtlStatDesc =='Single' ? 'Single' : (MrtlStatDesc == 'Married' ? 'Married' : (MrtlStatDesc == 'Inferred Married' ? 'Unknown' : (MrtlStatDesc == 'Inferred Single' ? 'Unknown' : MrtlStatDesc)))) as MrtlStatDesc,
'',
'',
'',
'',
'',
'',
LifeEvntExpectParInd,
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
(YrAtResCdDesc =='1 Year' ? '1-5 years' : (YrAtResCdDesc =='2 Years' ? '1-5 years' : (YrAtResCdDesc =='3 Years' ? '1-5 years' : (YrAtResCdDesc =='4 Years' ? '1-5 years' : (YrAtResCdDesc =='5 Years' ? '1-5 years' : (YrAtResCdDesc =='6 years' ? '6-10 years' : (YrAtResCdDesc =='7 Year' ? '6-10 years' : (YrAtResCdDesc =='8 Years' ? '6-10 years' : (YrAtResCdDesc =='9 Years' ? '6-10 years' : (YrAtResCdDesc =='10 Years' ? '6-10 years' : (YrAtResCdDesc =='11 Years' ? '11 and greater' : (YrAtResCdDesc =='12 Years' ? '11 and greater' : (YrAtResCdDesc =='13 Years' ? '11 and greater' : (YrAtResCdDesc =='14 Years' ? '11 and greater' : (YrAtResCdDesc =='Greater than 14 Years' ? '11 and greater' : (YrAtResCdDesc == 'Less than 1 year' ? 'Less than 1 year' : YrAtResCdDesc)))))))))))))))) as YrAtResCdDesc,
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE((BirthDt is not null?SUBSTRING(org.sears.analytics.SearchUTC(org.sears.analytics.ValidateDate(BirthDt)),5,7):''),'01','1'),'02','2'),'03','3'),'04','4'),'05','5'),'06','6'),'07','7'),'08','8'),'09','9'),
(BirthDt is not null?SUBSTRING(org.sears.analytics.SearchUTC(org.sears.analytics.ValidateDate(BirthDt)),0,4):''),
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
EstIncmCdDesc,
OccupCdDesc,
HmMrktValuDciCdDesc,
(MoveInDate is not null?org.sears.analytics.SearchUTC(org.sears.analytics.ValidateDate(CONCAT(CONCAT(CONCAT(SUBSTRING(MoveInDate,0,4),'-'),SUBSTRING(MoveInDate,4,6)),'-01'))):''),
HmConstrYrNbr,
LatDegQty,
LongtdDegQty,
LatRdnQty,
LongtRdnQty,
OccupntCntCdDesc,
REPLACE(REPLACE(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(((HobbCrftsInd is not null?HobbCrftsInd:'')=='Y'?'Crafts~':' ~'),((HobbPhotoInd is not null?HobbPhotoInd:'')=='Y'?'Photography~':' ~')),((HobbAvtnInd is not null?HobbAvtnInd:'')=='Y'?'Aviation~':' ~')),((HobbAutoMchncInd is not null?HobbAutoMchncInd:'')=='Y'?'Automotive Work/ Mechanics~':' ~')),((HobbSewKntwNdlwkInd is not null?HobbSewKntwNdlwkInd:'')=='Y'?'Sewing/Knitting/Needlework~':' ~')),((HobbWdwrkInd is not null?HobbWdwrkInd:'')=='Y'?'Woodworking~':' ~')),((HobbBoardGamPzzlInd is not null?HobbBoardGamPzzlInd:'')=='Y'?'Board Games/ Puzzles~':' ~')),((HmCmptrPlayCmptrGamInd is not null?HmCmptrPlayCmptrGamInd:'')=='Y'?'Plays computer games~':' ~')),((ComptrPltfmCd is not null?ComptrPltfmCd:'')=='Y'?'Personal Computer Platform~':' ~')),((DiyInd is not null?DiyInd:'')=='Y'?'DO It Yourself~':' ~')),' '),' ~',''),'~ ',''),
REPLACE(REPLACE(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(((PartcpSprtTennsInd is not null?PartcpSprtTennsInd:'')=='Y'?'Tennis~':' ~'),((PartcpSprtGolfInd is not null?PartcpSprtGolfInd:'')=='Y'?'Golf~':' ~')),((PartcpSprtSnowSkngInd is not null?PartcpSprtSnowSkngInd:'')=='Y'?'Snow Skiing~':' ~')),((PartcpSprtMtrcyInd is not null?PartcpSprtMtrcyInd:'')=='Y'?'Motorcycling~':' ~')),((PartcpSprtEqstrianInd is not null?PartcpSprtEqstrianInd:'')=='Y'?'Equestrian~':' ~')),((SpctrSprtAutoCycleRaceInd is not null?SpctrSprtAutoCycleRaceInd:'')=='Y'?'Auto/ Motorcycle Racing~':' ~')),((SpctrSprtFtbInd is not null?SpctrSprtFtbInd:'')=='Y'?'Football~':' ~')),((SpctrSprtBsbInd is not null?SpctrSprtBsbInd:'')=='Y'?'Baseball~':' ~')),((SpctrSprtBskInd is not null?SpctrSprtBskInd:'')=='Y'?'Basketball~':' ~')),((SpctrSprtHkyInd is not null?SpctrSprtHkyInd:'')=='Y'?'Hockey~':' ~')),((SpctrSprtSoccerInd is not null?SpctrSprtSoccerInd:'')=='Y'?'Soccer~':' ~')),' '),' ~',''),'~ ',''),
((SpctrSprtTnnsInd is not null?SpctrSprtTnnsInd:'')=='Y'?'Tennis':''),
((ElecCnsmrElecInd is not null?ElecCnsmrElecInd:'')=='Y'?'Electronics Consumer Electronics':''),
REPLACE(REPLACE(CONCAT(CONCAT(CONCAT(((ExerAerbcCrvscInd is not null?ExerAerbcCrvscInd:'')=='Y'?'Exercise Aerobic Cardiovascular~':' ~'),((ExerRunJoggngInd is not null?ExerRunJoggngInd:'')=='Y'?'Exercise Running Jogging~':' ~')),((ExerWalkInd is not null?ExerWalkInd:'')=='Y'?'Exercise Walking~':' ~')),' '),' ~',''),'~ ',''),
REPLACE(REPLACE(CONCAT(CONCAT(((FamlyChildIntInd is not null?FamlyChildIntInd:'')=='Y'?'Family Children Interests~':' ~'),((FamlyGchInd is not null?FamlyGchInd:'')=='Y'?'Family Grandchildren~':' ~')),' '),' ~',''),'~ ',''),
VehCntCdDesc,
((TruckOwnerInd is not null?TruckOwnerInd:'')=='1'?'Y':((TruckOwnerInd is not null?TruckOwnerInd:'')=='0'?'N':TruckOwnerInd)),
((MtrcyOwnerInd is not null?MtrcyOwnerInd:'')=='1'?'Y':((MtrcyOwnerInd is not null?MtrcyOwnerInd:'')=='0'?'N':MtrcyOwnerInd)),
((RvOwnerInd is not null?RvOwnerInd:'')=='1'?'Y':((RvOwnerInd is not null?RvOwnerInd:'')=='0'?'N':RvOwnerInd)),
((HmCmptrOwnerInd is not null?HmCmptrOwnerInd:'')=='1'?'Y':((HmCmptrOwnerInd is not null?HmCmptrOwnerInd:'')=='0'?'N':HmCmptrOwnerInd)),
((HmCmptrInetOnlineServInd is not null?HmCmptrInetOnlineServInd:'')=='1'?'Y':((HmCmptrInetOnlineServInd is not null?HmCmptrInetOnlineServInd:'')=='0'?'N':HmCmptrInetOnlineServInd)),
OperSysCdDesc,
((LifeEvntCollgGradnInd is not null?LifeEvntCollgGradnInd:'')=='1'?'Y':((LifeEvntCollgGradnInd is not null?LifeEvntCollgGradnInd:'')=='0'?'N':LifeEvntCollgGradnInd)),
((LifeEvntEmptyNestrInd is not null?LifeEvntEmptyNestrInd:'')=='1'?'Y':((LifeEvntEmptyNestrInd is not null?LifeEvntEmptyNestrInd:'')=='0'?'N':LifeEvntEmptyNestrInd)),
((LifeEvntEntrAdulthdInd is not null?LifeEvntEntrAdulthdInd:'')=='1'?'Y':((LifeEvntEntrAdulthdInd is not null?LifeEvntEntrAdulthdInd:'')=='0'?'N':LifeEvntEntrAdulthdInd)),
((LifeEvntVhclPurchIntentInd is not null?LifeEvntVhclPurchIntentInd:'')=='1'?'Y':((LifeEvntVhclPurchIntentInd is not null?LifeEvntVhclPurchIntentInd:'')=='0'?'N':LifeEvntVhclPurchIntentInd)),
((LifeEvntNewlywedInd is not null?LifeEvntNewlywedInd:'')=='1'?'Y':((LifeEvntNewlywedInd is not null?LifeEvntNewlywedInd:'')=='0'?'N':LifeEvntNewlywedInd)),
((LifeEvntRcntDvcInd is not null?LifeEvntRcntDvcInd:'')=='1'?'Y':((LifeEvntRcntDvcInd is not null?LifeEvntRcntDvcInd:'')=='0'?'N':LifeEvntRcntDvcInd)),
((LifeEvntChildNrHsGradtnInd is not null?LifeEvntChildNrHsGradtnInd:'')=='1'?'Y':((LifeEvntChildNrHsGradtnInd is not null?LifeEvntChildNrHsGradtnInd:'')=='0'?'N':LifeEvntChildNrHsGradtnInd)),
((LifeEvntRcntHmBuyerInd is not null?LifeEvntRcntHmBuyerInd:'')=='1'?'Y':((LifeEvntRcntHmBuyerInd is not null?LifeEvntRcntHmBuyerInd:'')=='0'?'N':LifeEvntRcntHmBuyerInd)),
((LifeEvntRcntMortBrrwrInd is not null?LifeEvntRcntMortBrrwrInd:'')=='1'?'Y':((LifeEvntRcntMortBrrwrInd is not null?LifeEvntRcntMortBrrwrInd:'')=='0'?'N':LifeEvntRcntMortBrrwrInd)),
((LifeEvntNewMoveInd is not null?LifeEvntNewMoveInd:'')=='1'?'Y':((LifeEvntNewMoveInd is not null?LifeEvntNewMoveInd:'')=='0'?'N':LifeEvntNewMoveInd)),
LifeEvntNewParCdDesc,
HmEqtyAvailRngCdDesc,
HmSqftgCdDesc,
((ElecClulrPhoneOwnerInd is not null?ElecClulrPhoneOwnerInd:'')=='1'?'Y':((ElecClulrPhoneOwnerInd is not null?ElecClulrPhoneOwnerInd:'')=='0'?'N':ElecClulrPhoneOwnerInd)),
((CrCardUserInd is not null?CrCardUserInd:'')=='1'?'Y':((CrCardUserInd is not null?CrCardUserInd:'')=='0'?'N':CrCardUserInd)),
REPLACE(REPLACE(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(((DonteRlgnCauseInd is not null?DonteRlgnCauseInd:'')=='Y'?'Religious Causes~':' ~'),((DonteVtranCauseInd is not null?DonteVtranCauseInd:'')=='Y'?'Veteran Causes~':' ~')),((DonteChrtablCauseInd is not null?DonteChrtablCauseInd:'')=='Y'?'Charitable Causes~':' ~')),((DontePolCauseInd is not null?DontePolCauseInd:'')=='Y'?'Political Causes~':' ~')),((DonteConsrvtvCauseInd is not null?DonteConsrvtvCauseInd:'')=='Y'?'Conservative Political Causes~':' ~')),((DonteLibrlCauseInd is not null?DonteLibrlCauseInd:'')=='Y'?'Liberal Political Causes~':' ~')),((DonteAnimlWelfareInd is not null?DonteAnimlWelfareInd:'')=='Y'?'Animal Welfare~':' ~')),((DonteArtOrCltrlInd is not null?DonteArtOrCltrlInd:'')=='Y'?'Arts or Cultural~':' ~')),((DonteChildCauseInd is not null?DonteChildCauseInd:'')=='Y'?'Children Causes~':' ~')),((DonteEnvirOrWldlfInd is not null?DonteEnvirOrWldlfInd:'')=='Y'?'Environment or Wildlife~':' ~')),((DonteHlthCauseInd is not null?DonteHlthCauseInd:'')=='Y'?'Health Causes~':' ~')),((DonteIntlAidInd is not null?DonteIntlAidInd:'')=='Y'?'International Aid~':' ~')),((DonteOtherCauseInd is not null?DonteOtherCauseInd:'')=='Y'?'Other Causes~':' ~')),' '),' ~',''),'~ ',''),
DonteVtranCauseInd,
HmExteriorCdDesc,
HmHeatSrcCdDesc,
HmRoofTypeCdDesc,
HmRoomQty,
((SwimPoolInd is not null?SwimPoolInd:'')=='1'?'Y':((SwimPoolInd is not null?SwimPoolInd:'')=='0'?'N':SwimPoolInd)),
'',
REPLACE(REPLACE(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(((REPLACE(REPLACE(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(((HobbCrftsInd is not null?HobbCrftsInd:'')=='Y'?'Crafts~':' ~'),((HobbPhotoInd is not null?HobbPhotoInd:'')=='Y'?'Photography~':' ~')),((HobbAvtnInd is not null?HobbAvtnInd:'')=='Y'?'Aviation~':' ~')),((HobbAutoMchncInd is not null?HobbAutoMchncInd:'')=='Y'?'Automotive Work/ Mechanics~':' ~')),((HobbSewKntwNdlwkInd is not null?HobbSewKntwNdlwkInd:'')=='Y'?'Sewing/Knitting/Needlework~':' ~')),((HobbWdwrkInd is not null?HobbWdwrkInd:'')=='Y'?'Woodworking~':' ~')),((HobbBoardGamPzzlInd is not null?HobbBoardGamPzzlInd:'')=='Y'?'Board Games/ Puzzles~':' ~')),((HmCmptrPlayCmptrGamInd is not null?HmCmptrPlayCmptrGamInd:'')=='Y'?'Plays computer games~':' ~')),((ComptrPltfmCd is not null?ComptrPltfmCd:'')=='Y'?'Personal Computer Platform~':' ~')),((DiyInd is not null?DiyInd:'')=='Y'?'DO It Yourself~':' ~')),' '),' ~',''),'~ ',''))!=''?CONCAT((REPLACE(REPLACE(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(((HobbCrftsInd is not null?HobbCrftsInd:'')=='Y'?'Crafts~':' ~'),((HobbPhotoInd is not null?HobbPhotoInd:'')=='Y'?'Photography~':' ~')),((HobbAvtnInd is not null?HobbAvtnInd:'')=='Y'?'Aviation~':' ~')),((HobbAutoMchncInd is not null?HobbAutoMchncInd:'')=='Y'?'Automotive Work/ Mechanics~':' ~')),((HobbSewKntwNdlwkInd is not null?HobbSewKntwNdlwkInd:'')=='Y'?'Sewing/Knitting/Needlework~':' ~')),((HobbWdwrkInd is not null?HobbWdwrkInd:'')=='Y'?'Woodworking~':' ~')),((HobbBoardGamPzzlInd is not null?HobbBoardGamPzzlInd:'')=='Y'?'Board Games/ Puzzles~':' ~')),((HmCmptrPlayCmptrGamInd is not null?HmCmptrPlayCmptrGamInd:'')=='Y'?'Plays computer games~':' ~')),((ComptrPltfmCd is not null?ComptrPltfmCd:'')=='Y'?'Personal Computer Platform~':' ~')),((DiyInd is not null?DiyInd:'')=='Y'?'DO It Yourself~':' ~')),' '),' ~',''),'~ ','')),'~'):' ~'),((REPLACE(REPLACE(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(((PartcpSprtTennsInd is not null?PartcpSprtTennsInd:'')=='Y'?'Tennis~':' ~'),((PartcpSprtGolfInd is not null?PartcpSprtGolfInd:'')=='Y'?'Golf~':' ~')),((PartcpSprtSnowSkngInd is not null?PartcpSprtSnowSkngInd:'')=='Y'?'Snow Skiing~':' ~')),((PartcpSprtMtrcyInd is not null?PartcpSprtMtrcyInd:'')=='Y'?'Motorcycling~':' ~')),((PartcpSprtEqstrianInd is not null?PartcpSprtEqstrianInd:'')=='Y'?'Equestrian~':' ~')),((SpctrSprtAutoCycleRaceInd is not null?SpctrSprtAutoCycleRaceInd:'')=='Y'?'Auto/ Motorcycle Racing~':' ~')),((SpctrSprtFtbInd is not null?SpctrSprtFtbInd:'')=='Y'?'Football~':' ~')),((SpctrSprtBsbInd is not null?SpctrSprtBsbInd:'')=='Y'?'Baseball~':' ~')),((SpctrSprtBskInd is not null?SpctrSprtBskInd:'')=='Y'?'Basketball~':' ~')),((SpctrSprtHkyInd is not null?SpctrSprtHkyInd:'')=='Y'?'Hockey~':' ~')),((SpctrSprtSoccerInd is not null?SpctrSprtSoccerInd:'')=='Y'?'Soccer~':' ~')),' '),' ~',''),'~ ',''))!=''?CONCAT((REPLACE(REPLACE(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(((PartcpSprtTennsInd is not null?PartcpSprtTennsInd:'')=='Y'?'Tennis~':' ~'),((PartcpSprtGolfInd is not null?PartcpSprtGolfInd:'')=='Y'?'Golf~':' ~')),((PartcpSprtSnowSkngInd is not null?PartcpSprtSnowSkngInd:'')=='Y'?'Snow Skiing~':' ~')),((PartcpSprtMtrcyInd is not null?PartcpSprtMtrcyInd:'')=='Y'?'Motorcycling~':' ~')),((PartcpSprtEqstrianInd is not null?PartcpSprtEqstrianInd:'')=='Y'?'Equestrian~':' ~')),((SpctrSprtAutoCycleRaceInd is not null?SpctrSprtAutoCycleRaceInd:'')=='Y'?'Auto/ Motorcycle Racing~':' ~')),((SpctrSprtFtbInd is not null?SpctrSprtFtbInd:'')=='Y'?'Football~':' ~')),((SpctrSprtBsbInd is not null?SpctrSprtBsbInd:'')=='Y'?'Baseball~':' ~')),((SpctrSprtBskInd is not null?SpctrSprtBskInd:'')=='Y'?'Basketball~':' ~')),((SpctrSprtHkyInd is not null?SpctrSprtHkyInd:'')=='Y'?'Hockey~':' ~')),((SpctrSprtSoccerInd is not null?SpctrSprtSoccerInd:'')=='Y'?'Soccer~':' ~')),' '),' ~',''),'~ ','')),'~'):' ~')),((((SpctrSprtTnnsInd is not null?SpctrSprtTnnsInd:'')=='Y'?'Tennis':''))!=''?CONCAT((((SpctrSprtTnnsInd is not null?SpctrSprtTnnsInd:'')=='Y'?'Tennis':'')),'~'):' ~')),((((ElecCnsmrElecInd is not null?ElecCnsmrElecInd:'')=='Y'?'Electronics Consumer Electronics':''))!=''?CONCAT((((ElecCnsmrElecInd is not null?ElecCnsmrElecInd:'')=='Y'?'Electronics Consumer Electronics':'')),'~'):' ~')),((REPLACE(REPLACE(CONCAT(CONCAT(CONCAT(((ExerAerbcCrvscInd is not null?ExerAerbcCrvscInd:'')=='Y'?'Exercise Aerobic Cardiovascular~':' ~'),((ExerRunJoggngInd is not null?ExerRunJoggngInd:'')=='Y'?'Exercise Running Jogging~':' ~')),((ExerWalkInd is not null?ExerWalkInd:'')=='Y'?'Exercise Walking~':' ~')),' '),' ~',''),'~ ',''))!=''?CONCAT((REPLACE(REPLACE(CONCAT(CONCAT(CONCAT(((ExerAerbcCrvscInd is not null?ExerAerbcCrvscInd:'')=='Y'?'Exercise Aerobic Cardiovascular~':' ~'),((ExerRunJoggngInd is not null?ExerRunJoggngInd:'')=='Y'?'Exercise Running Jogging~':' ~')),((ExerWalkInd is not null?ExerWalkInd:'')=='Y'?'Exercise Walking~':' ~')),' '),' ~',''),'~ ','')),'~'):' ~')),((REPLACE(REPLACE(CONCAT(CONCAT(((FamlyChildIntInd is not null?FamlyChildIntInd:'')=='Y'?'Family Children Interests~':' ~'),((FamlyGchInd is not null?FamlyGchInd:'')=='Y'?'Family Grandchildren~':' ~')),' '),' ~',''),'~ ',''))!=''?CONCAT((REPLACE(REPLACE(CONCAT(CONCAT(((FamlyChildIntInd is not null?FamlyChildIntInd:'')=='Y'?'Family Children Interests~':' ~'),((FamlyGchInd is not null?FamlyGchInd:'')=='Y'?'Family Grandchildren~':' ~')),' '),' ~',''),'~ ','')),'~'):' ~')),' '),' ~',''),'~ ',''),
'',
'',
EduLvlCdDesc,
REPLACE(REPLACE(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(((ChildMale0to2Ind is not null?ChildMale0to2Ind:'')=='Y'?'0-2 Male~':' ~'),((ChildMale3to5Ind is not null?ChildMale3to5Ind:'')=='Y'?'3-5 Male~':' ~')),((ChildMale6to10Ind is not null?ChildMale6to10Ind:'')=='Y'?'6-10 Male~':' ~')),((ChildMale11to15Ind is not null?ChildMale11to15Ind:'')=='Y'?'11-15 Male~':' ~')),((ChildMale16to17Ind is not null?ChildMale16to17Ind:'')=='Y'?'16-17 Male~':' ~')),((ChildFem0to2Ind is not null?ChildFem0to2Ind:'')=='Y'?'0-2 Female~':' ~')),((ChildFem3to5Ind is not null?ChildFem3to5Ind:'')=='Y'?'3-5 Female~':' ~')),((ChildFem6to10Ind is not null?ChildFem6to10Ind:'')=='Y'?'6-10 Female~':' ~')),((ChildFem11to15Ind is not null?ChildFem11to15Ind:'')=='Y'?'11-15 Female~':' ~')),((ChildFem16to17Ind is not null?ChildFem16to17Ind:'')=='Y'?'16-17 Female~':' ~')),' '),' ~',''),'~ ',''),
--'',
(BirthDt==''?'':(chararray)YearsBetween(CurrentTime(),ToDate(BirthDt,'yyyy-MM-dd HH:mm:ss'))),
TotAddress,
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
--(CASE WHEN SIZE(pettype)==0 THEN 'N' ELSE 'Y' END) as PetOwnerIndicator,
((FamlyDogOwnerInd is null?'':(FamlyDogOwnerInd==''?'':FamlyDogOwnerInd))=='Y'?'Y':((FamlyCatOwnerInd is null?'':(FamlyCatOwnerInd==''?'':FamlyCatOwnerInd))=='Y'?'Y':((FamlyOtherPetOwnerInd is null?'':(FamlyOtherPetOwnerInd==''?'':FamlyOtherPetOwnerInd))=='Y'?'Y':''))),
'N',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'';};


STORE foreach_CDI into '$MADE_WORK_DIR/cdi/cdiaggcollection' using PigStorage('\t');
