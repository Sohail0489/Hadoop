/*****************************************************************************************************************
Description: This script pulls data from cohort3 dataset and sywdervied interactions
******************************************************************************************************************/

REGISTER '$MADE_JAR_DIR/Search.jar';

load_SYW = load '$MADE_WORK_DIR/syw/SywProfAttr/sywcom_transform' using PigStorage('\t') as (
  lyltycardnbr :chararray,
  email :chararray,
  birthday :chararray,
  gender :chararray,
  ethnicity :chararray,
  aboutme :chararray,
  elementryschoolname :chararray,
  elementryschoolcity :chararray,
  elementryschoolstate :chararray,
  elementryschoolcountry :chararray,
  elementryschoolfromdate :chararray,
  elementryschooltodate :chararray,
  middleschoolname :chararray,
  middleschoolcity :chararray,
  middleschoolstate :chararray,
  middleschoolcountry :chararray,
  middleschoolfromdate :chararray,
  middleschooltodate :chararray,
  highschoolname :chararray,
  highschoolcity :chararray,
  highschoolstate :chararray,
  highschoolcountry :chararray,
  highschoolfromdate :chararray,
  highschooltodate :chararray,
  undergraduatemajor :chararray,
  undergraduatename :chararray,
  undergraduatecity :chararray,
  undergraduatestate :chararray,
  undergraduatecountry :chararray,
  undergraduatefromdate :chararray,
  undergraduatetodate :chararray,
  graduatemajor :chararray,
  graduatename :chararray,
  graduatecity :chararray,
  graduatestate :chararray,
  graduatecountry :chararray,
  graduatefromdate :chararray,
  graduatetodate :chararray,
  postgraduatemajor :chararray,
  postgraduatename :chararray,
  postgraduatecity :chararray,
  postgraduatestate :chararray,
  postgraduatecountry :chararray,
  postgraduatefromdate :chararray,
  postgraduatetodate :chararray,
  ecofriendlyproducts :chararray,
  locallymanufacturedproducts :chararray,
  cookingexpertise :chararray,
  alcoholhabit :chararray,
  hostguestfrequency :chararray,
  cookingfor :chararray,
  cinemavisitfrequency :chararray,
  moviesrentingfrequency :chararray,
  numberofbooksreadannualy :chararray,
  travelfrequency :chararray,
  vacationfrequency :chararray,
  electricitycompany :chararray,
  gascompany :chararray,
  internetserviceprovider :chararray,
  mobilenetworkprovider :chararray,
  primarygrocerystore :chararray,
  primarydrugstore :chararray,
  telephonecompany :chararray,
  wastemanagementcompany :chararray,
  watercompany :chararray,
  aarpmembership :chararray,
  religion :chararray,
  politicalparty :chararray,
  typeofhome :chararray,
  numberofbedrooms :chararray,
  numberofbathrooms :chararray,
  homesizesquarefeet :chararray,
  primarybuildingmaterial :chararray,
  homeownershiptype :chararray,
  timeofresidence :chararray,
  yardshed :chararray,
  yardtrees :chararray,
  tvprovider :chararray,
  netflixsubscription :chararray,
  ownappletv :chararray,
  height :chararray,
  weight :chararray,
  bodyshape :chararray,
  tshirtsize :chararray,
  shoesize :chararray,
  bust :chararray,
  waist :chararray,
  hip :chararray,
  favoriteclothingstyle :chararray,
  workdresscode :chararray,
  relationshipstatus :chararray,
  spousegender :chararray,
  spousebirthdate :chararray,
  spouseanniversary :chararray,
  expectingababy :chararray,
  expectedgender :chararray,
  expectedduedate :chararray,
  fatherbirthday :chararray,
  motherbirthday :chararray,
  parentsanniversary :chararray,
  usecorrectivelenses :chararray,
  lefteyecorrectivelensprescription :chararray,
  righteyecorrectivelensprescription :chararray,
  exerciseatgym :chararray,
  gymclub :chararray,
  monthlycostofgym :chararray,
  frequencyofexercise :chararray,
  tryingtoloseweight :chararray,
  usedailysupplementsorvitamins :chararray,
  homeaddresscity :chararray,
  homeaddressstate :chararray,
  homeaddresscountry :chararray,
  homeaddresszipcode :chararray,
  workaddresscity :chararray,
  workaddressstate :chararray,
  workaddresscountry :chararray,
  workaddresszipcode :chararray,
  parentsaddresscity :chararray,
  parentsaddressstate :chararray,
  parentsaddresscountry :chararray,
  parentsaddresszipcode :chararray,
  homephonenumber :chararray,
  cellphonenumber :chararray,
  workphonenumber :chararray,
  facebookprofile :chararray,
  instagramprofile :chararray,
  twitterprofile :chararray,
  myspaceprofile :chararray,
  linkedinprofile :chararray,
  pinterestprofile :chararray,
  msnprofile :chararray,
  googleplusprofile :chararray,
  soundcloudprofile :chararray,
  bankname :chararray,
  bankcity :chararray,
  bankstate :chararray,
  bankcountry :chararray,
  bankzipcode :chararray,
  primarycreditcard :chararray,
  averagecarmileageperyear :chararray,
  beautyproductsrange :chararray,
  beautyservicesfrequency :chararray,
  childroom :chararray,
  decorupdatefrequency :chararray,
  garagetype :chararray,
  homemaintenance :chararray,
  residenceduration :chararray,
  numberoftvsinhome :chararray,
  owngoogleglass :chararray,
  balconypatiosize :chararray,
  personalbeautyactivities :chararray,
  childrenschooluniform :chararray,
  interestedinsportinggoodsproducts :chararray,
  vehiclecare :chararray,
  mattressessize :chararray,
  typeofyard :chararray,
  tvsubscriptionpackages :chararray,
  favoritetvchannels :chararray,
  favoritetvshows :chararray,
  favoriteshirtcolors :chararray,
  favoritepantscolor :chararray,
  homeaddresscitystate :chararray,
  homeaddresscitystatezip :chararray,
  homeaddresscitystatecountry :chararray,
  favoriteshoecolors :chararray,
  homeaddresszipcountry :chararray,
  favoritehatstyles :chararray,
  favoriteapprelbrands :chararray,
  artscrafts :chararray,
  collectionhobbies :chararray,
  games :chararray,
  martialarts :chararray,
  outdooractivities :chararray,
  performingarts :chararray,
  scienceelectronics :chararray,
  individualsports :chararray,
  racketsports :chararray,
  teamsports :chararray,
  watersports :chararray,
  creditcardsinuse :chararray,
  wheeledsports :chararray,
  wintersports :chararray,
  other :chararray,
  indoorhobbies :chararray,
  indoorcompetitivehobbies :chararray,
  outdoorhobbies :chararray,
  observationhobbies :chararray,
  outdoorcompetitivehobbies :chararray,
  pettype :chararray,
  petbreed :chararray,
  petweight :chararray,
  petbirthday :chararray,
  wearablecomputinggadgets :chararray,
  carmake :chararray,
  carmodel :chararray,
  caryear :chararray,
  carwarrantyexpiration :chararray,
  carlastmaintenancedate :chararray,
  carmilege :chararray,
  motorbikemake :chararray,
  motorbikemodel :chararray,
  motorbikeyear :chararray,
  motorbikewarrantyexpiration :chararray,
  motorbikelastmaintenancedate :chararray,
  motorbikemilege :chararray,
  healthissues :chararray,
  siblingsgender :chararray,
  siblinganniversary :chararray,
  siblingbirthday :chararray,
  employmentposition :chararray,
  employmentcompany :chararray,
  employmentcity :chararray,
  employmentstate :chararray,
  employmentcountry :chararray,
  employmentfromdate :chararray,
  employmenttodate :chararray,
  employmentindustry :chararray,
  preferredbeautyproducts :chararray,
  carusage :chararray,
  childrenextracurricularactivities :chararray,
  childrensportsrelatedactivities :chararray,
  exercisereasons :chararray,
  furniturestyletheme :chararray,
  preferredhomefurnishingshop :chararray,
  thingstolookinanewcar :chararray,
  otherroomstype :chararray,
  preferredyardactivities :chararray,
  preferredweatherforoutdooractivities :chararray,
  preferredsmartphonetype :chararray,
  preferredsmartphonefeatures :chararray,
  activitiestostayinshape :chararray,
  vehiclerelatedactivities :chararray,
  childgender :chararray,
  childanniversary :chararray,
  childbirthdate :chararray,
  languagefluency :chararray,
  language :chararray,
  areyouselfemployed :chararray,
  professionalskills :chararray,
  generalnutritionalpreferences :chararray,
  favoriterestaurants :chararray,
  favoritedishes :chararray,
  cookingreason :chararray,
  favoritemusicartists :chararray,
  favoritemusicstyles :chararray,
  favoritemusicstores :chararray,
  onlinemusicservices :chararray,
  favoritemovies :chararray,
  favoritegenres :chararray,
  favoriteauthors :chararray,
  favoritebooks :chararray,
  preferablevacationmonths :chararray,
  preferablevacationdestination :chararray,
  preferablevacationtype :chararray,
  airlineclubmembership :chararray,
  rentalcarclubmembership :chararray,
  magazinesubscriptions :chararray,
  charityname :chararray,
  charitykeycontact :chararray,
  charitytimeofyear :chararray,
  yardsquarefootage :chararray,
  yardgarage :chararray,
  smokinghabits :chararray,
  birthdaymonth :chararray,
  birthdayyear :chararray,
  emaildomain :chararray,
  socialmediaprofiles :chararray,
  animalrelatedhobbies :chararray,
  allhobbies :chararray,
  educationlevel :chararray,
  haschildren :chararray,
  memberage :chararray,
  homepurchaseprice :chararray,
  mortgagepayments :chararray,
  monthlyrent :chararray,
  yearlyincome :chararray,
  fourtripsind :chararray,
  onlineactvind :chararray,
  redeemind :chararray,
  srsccuserind :chararray,
  sywmaxind :chararray,
  sywrvipind :chararray,
  emailind :chararray,
  tentripsind :chararray,
  eleventripsind :chararray,
  tottripsind :chararray,
  totsls :chararray,
  tripperbucket :chararray,
  spendbucket :chararray);

  
load_sywderivedinteractions = load '$MADE_WORK_DIR/syw/SywIntrctns/sywintrctns_transform' using PigStorage('\t') as (
lyltycardnbr:chararray,
load_7_type::interactionstype7,
load_7_detail::interactionsdetail7,
load_365_type::interactionstype365,
load_365_detail::interactionsdetail365);

join_files = join  load_SYW by lyltycardnbr left outer, load_sywderivedinteractions by lyltycardnbr;

foreach_SYW = foreach join_files 
{
residenceduration=(residenceduration == 'Less than 1 year' ? 'Less than 1 year' : (residenceduration == '1-5 years' ? '1-5 years' : (residenceduration == '6-10 years' ? '6-10 years' : (residenceduration == '11-15 years' ? '11 and greater' : (residenceduration == '16-20 years' ? '11 and greater' : (residenceduration == '20+ years' ? '11 and greater' : 'Other'))))));
educationlevel=(educationlevel == '1' ? 'Post Graduate' : (educationlevel == '2' ? 'Completed Graduate' : (educationlevel == '3' ? 'Completed Under Graduate' : (educationlevel == '4' ? 'Completed High School': (educationlevel == '5' ? 'Completed Middle School' : (educationlevel == '6' ? 'Completed Elementary School' : ''))))));
pettype=org.sears.analytics.SYWPetType(pettype);
PetOwnerIndicatorSYW = (CASE WHEN SIZE(pettype)==0 THEN 'N' ELSE 'Y' END);
homesizesquarefeet=(CASE when ( (int) homesizesquarefeet >=30001 and (int) homesizesquarefeet <=45000) THEN 'BETWEEN 30,001 - 45,000 SQFT'
                         when ((int) homesizesquarefeet >=90001 and (int) homesizesquarefeet <=220000) THEN 'BETWEEN 90,001 - 220,000 SQFT'
                         when ((int) homesizesquarefeet >=20001  and  (int) homesizesquarefeet <=30000) THEN 'BETWEEN 20,001 - 30,000 SQFT'
                         when ((int) homesizesquarefeet >=10001  and  (int) homesizesquarefeet <=15000) THEN 'BETWEEN  10,001 - 15,000 SQFT'
                         when ((int) homesizesquarefeet >=15001  and  (int) homesizesquarefeet <=20000) THEN 'BETWEEN  15,001 - 20,000 SQFT'
                         when ((int) homesizesquarefeet >=5000  and  (int) homesizesquarefeet <=10000) THEN 'BETWEEN 5,000 - 10,000 SQFT'
                         when ((int) homesizesquarefeet >=45001  and (int)  homesizesquarefeet <=90000) THEN 'BETWEEN 45,001 - 90,000 SQFT'
                         when ((int) homesizesquarefeet <5000)   THEN 'Less than 5,000 SQFT' END);
generate
CONCAT(load_SYW::lyltycardnbr,'SYW') as key,
'SYW' as source,
load_SYW::lyltycardnbr as lyltycardnbr,
'',
'',
birthday,
gender,
ethnicity,
aboutme,
language,
TRIM(languagefluency) as languagefluency,
elementryschoolname,
elementryschoolcity,
elementryschoolstate,
elementryschoolcountry,
elementryschoolfromdate,
elementryschooltodate,
middleschoolname,
middleschoolcity,
middleschoolstate,
middleschoolcountry,
middleschoolfromdate,
middleschooltodate,
highschoolname,
highschoolcity,
highschoolstate,
highschoolcountry,
highschoolfromdate,
highschooltodate,
undergraduatemajor,
undergraduatename,
undergraduatecity,
undergraduatestate,
undergraduatecountry,
undergraduatefromdate,
undergraduatetodate,
graduatemajor,
graduatename,
graduatecity,
graduatestate,
graduatecountry,
graduatefromdate,
graduatetodate,
postgraduatemajor,
postgraduatename,
postgraduatecity,
postgraduatestate,
postgraduatecountry,
postgraduatefromdate,
postgraduatetodate,
areyouselfemployed,
employmentposition,
employmentcompany,
employmentcity,
employmentstate,
employmentcountry,
employmentfromdate,
employmenttodate,
employmentindustry,
professionalskills,
ecofriendlyproducts,
locallymanufacturedproducts,
generalnutritionalpreferences,
cookingexpertise,
alcoholhabit,
favoriterestaurants,
hostguestfrequency,
favoritedishes,
cookingfor,
cookingreason,
favoritemusicartists,
favoritemusicstyles,
favoritemusicstores,
onlinemusicservices,
favoritemovies,
favoritegenres,
cinemavisitfrequency,
moviesrentingfrequency,
magazinesubscriptions,
numberofbooksreadannualy,
favoriteauthors,
favoritebooks,
travelfrequency,
vacationfrequency,
preferablevacationmonths,
preferablevacationdestination,
preferablevacationtype,
pettype,
petbreed,
petweight,
petbirthday,
electricitycompany,
gascompany,
internetserviceprovider,
mobilenetworkprovider,
primarygrocerystore,
primarydrugstore,
telephonecompany,
wastemanagementcompany,
watercompany,
airlineclubmembership,
rentalcarclubmembership,
aarpmembership,
religion,
politicalparty,
charityname,
charitykeycontact,
charitytimeofyear,
typeofhome,
numberofbedrooms,
numberofbathrooms,
mattressessize,
homesizesquarefeet,
primarybuildingmaterial,
homeownershiptype,
timeofresidence,
typeofyard,
yardsquarefootage,
yardgarage,
yardshed,
yardtrees,
tvprovider,
tvsubscriptionpackages,
favoritetvchannels,
favoritetvshows,
netflixsubscription,
ownappletv,
carmake,
carmodel,
caryear,
carwarrantyexpiration,
carlastmaintenancedate,
carmilege,
motorbikemake,
motorbikemodel,
motorbikeyear,
motorbikewarrantyexpiration,
motorbikelastmaintenancedate,
motorbikemilege,
height,
weight,
bodyshape,
tshirtsize,
shoesize,
bust,
waist,
hip,
favoriteclothingstyle,
favoriteshirtcolors,
favoritepantscolor,
favoriteshoecolors,
favoritehatstyles,
workdresscode,
favoriteapprelbrands,
artscrafts,
collectionhobbies,
games,
martialarts,
outdooractivities,
performingarts,
scienceelectronics,
individualsports,
racketsports,
teamsports,
watersports,
wheeledsports,
wintersports,
other,
indoorhobbies,
indoorcompetitivehobbies,
outdoorhobbies,
observationhobbies,
outdoorcompetitivehobbies,
relationshipstatus,
spousegender,
spousebirthdate,
spouseanniversary,
org.sears.analytics.SYWChildGender(childgender),
childbirthdate,
childanniversary,
(CASE expectingababy WHEN 'Yes' THEN 'Y' ELSE 'N' END) as expectingababy,
expectedgender,
expectedduedate,
fatherbirthday,
motherbirthday,
parentsanniversary,
siblingsgender,
siblinganniversary,
siblingbirthday,
usecorrectivelenses,
lefteyecorrectivelensprescription,
righteyecorrectivelensprescription,
exerciseatgym,
gymclub,
monthlycostofgym,
healthissues,
frequencyofexercise,
tryingtoloseweight,
usedailysupplementsorvitamins,
smokinghabits,
wearablecomputinggadgets,
homeaddresscity,
org.sears.analytics.State(homeaddressstate) as homeaddressstatecode,
homeaddressstate,
org.sears.analytics.State(homeaddresscitystate) as homeaddresscitystatecode,
homeaddresscountry,
homeaddresszipcode,
workaddresscity,
workaddressstate,
org.sears.analytics.State(workaddressstate) as workaddresssstatecode,
workaddresscountry,
workaddresszipcode,
parentsaddresscity,
parentsaddressstate,
parentsaddresscountry,
parentsaddresszipcode,
homephonenumber,
cellphonenumber,
workphonenumber,
bankname,
bankcity,
bankstate,
bankcountry,
bankzipcode,
primarycreditcard,
creditcardsinuse,
averagecarmileageperyear,
preferredbeautyproducts,
beautyproductsrange,
beautyservicesfrequency,
carusage,
childroom,
childrenextracurricularactivities,
childrensportsrelatedactivities,
decorupdatefrequency,
exercisereasons,
furniturestyletheme,
garagetype,
preferredhomefurnishingshop,
homemaintenance,
residenceduration,
thingstolookinanewcar,
numberoftvsinhome,
otherroomstype,
owngoogleglass,
balconypatiosize,
personalbeautyactivities,
preferredyardactivities,
preferredweatherforoutdooractivities,
preferredsmartphonetype,
childrenschooluniform,
preferredsmartphonefeatures,
interestedinsportinggoodsproducts,
activitiestostayinshape,
vehiclecare,
vehiclerelatedactivities,
socialmediaprofiles,
emaildomain,
'',
'',
'',
srsccuserind,
'',
'',
'',
'',
birthdaymonth,
birthdayyear,
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
animalrelatedhobbies,
allhobbies,
'',
'',
educationlevel,
haschildren,
'',
'',
homepurchaseprice,
mortgagepayments,
monthlyrent,
yearlyincome,
interactionstype7,
interactionsdetail7,
interactionstype365,
interactionsdetail365,
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
PetOwnerIndicatorSYW as PetOwnerIndicator,
'Y' as SYWProfileIndicator,
birthday as BirthdaySYW,
gender as GenderSYW,
ethnicity as EthnicitySYW,
language as LanguageSYW,
pettype as PetTypeSYW,
politicalparty as PoliticalPartySYW,
typeofhome as TypeofhomeSYW,
homesizesquarefeet as HomeSizeSYW,
homeownershiptype as HomeOwnershipTypeSYW,
relationshipstatus as RelationshipStatusSYW,
residenceduration as ResidenceDurationSYW,
socialmediaprofiles as SocialMediaProfilesSYW,
birthdaymonth as BirthdayMonthSYW,
birthdayyear as BirthdayYearSYW,
allhobbies as AllHobbiesSYW,
educationlevel as EducationLevelSYW,
haschildren as HasChildrenSYW,
--'',
(birthday==''?'':(chararray)YearsBetween(CurrentTime(),ToDate(birthday))),
'',
PetOwnerIndicatorSYW,
'',
'',
--
'',
'',
'',
'',
'',
'',
'',
'';};

STORE foreach_SYW INTO '$MADE_WORK_DIR/syw/sywaggcollection' using PigStorage('\t');
