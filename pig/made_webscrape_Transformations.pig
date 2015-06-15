/*****************************************************************************************************************
Script Name: webscrape_transformations.pig    
Author: Srujan Dussa 
Create Date: 01/06/2015
Modified Date: 01/06/2015
Version: 1.0
Description: This script pulls the required webscrape attributes for the collection.
******************************************************************************************************************/

/*****************************************************************************************************************
Loading all web scrape tables into relations
*****************************************************************************************************************/

load_TwitterProfWebScrape = load '$MAP_PROD_DIR/webscrape/TwitterProfWebScrape/current' using PigStorage('\u0001') as 
(  processed_tmp:chararray,
LyltyCardNbr:chararray,
MbrNm:chararray,
ScpDt:chararray,
ScpUrl:chararray,
TweetsCnt:chararray,
FowingCnt:chararray,
FowrCnt:chararray,
ScrnNm:chararray,
Locn:chararray,
Bio:chararray
);

load_LinkedInProfWebScrape = load '$MAP_PROD_DIR/webscrape/LinkedInProfWebScrape/current' using PigStorage('\u0001') as
(  processed_tmp:chararray,
LyltyCardNbr:chararray,
MbrNm:chararray,
ScpDt:chararray,
ScpUrl:chararray,
JobTitle:chararray,
Locn:chararray,
Indy:chararray,
Co:chararray,
School:chararray
);

join_twitter_linkedin = join load_LinkedInProfWebScrape by LyltyCardNbr full outer, load_TwitterProfWebScrape by LyltyCardNbr;

webscrape_attributes = foreach join_twitter_linkedin generate load_TwitterProfWebScrape::LyltyCardNbr AS LyltyCardNbr1, load_LinkedInProfWebScrape::LyltyCardNbr AS LyltyCardNbr2, load_TwitterProfWebScrape::ScpUrl AS Twitter_Url, load_LinkedInProfWebScrape::ScpUrl AS LinkedIn_Url;

filter_data = FILTER webscrape_attributes by (LyltyCardNbr1 is not null or LyltyCardNbr2 is not null);

foreach_web = foreach filter_data generate (LyltyCardNbr1 is null?LyltyCardNbr2:LyltyCardNbr1) AS LyltyCardNbr,Twitter_Url,LinkedIn_Url;

STORE foreach_web into '$MADE_WORK_DIR/webscrape/webscrape_transformed' using PigStorage('\t');

