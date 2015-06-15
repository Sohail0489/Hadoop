A = Load '/smith/syw_member_repo/Telluride/POS_Detailed' using PigStorage ('\t') AS(
lyltycardnbr :chararray,
srs_soar_nm :chararray,
total_srs_sales :float,
total_srs_tripcount :int,
kmt_soar_nm :chararray,
total_kmt_sales :float,
total_kmt_tripcount :int,
shc_soar_nm :chararray,
total_shc_sales :float,
total_shc_tripcount :int);

B = FOREACH A {
a= CONCAT(lyltycardnbr,'_');
GENERATE
CONCAT(a,shc_soar_nm) as key,
lyltycardnbr,
srs_soar_nm,
total_srs_sales,
total_srs_tripcount,
kmt_soar_nm,
total_kmt_sales,
total_kmt_tripcount,
shc_soar_nm,
total_shc_sales,
total_shc_tripcount;};

STORE B into '/smith/syw_member_repo/Telluride/POS_Detailed_Solr' using PigStorage('\t');
