
%default setdt         `date +"%Y-%m-%d"`;
%default set7days      `date +%Y-%m-%d -d "7 day ago"`;
%default set365days    `date +%Y-%m-%d -d "365 day ago"`;

load_file = load '$MADE_WORK_DIR/syw/SywIntrctns/sywInteractionsMemberProduct' using PigStorage('\t') as (
syw_member_id:chararray,
intractdatetime:chararray,
syw_user_id:chararray,
interaction_id:chararray,
interaction_type:chararray,
division:chararray,
item:chararray,
ksn:chararray,
soar_no:chararray,
soar_nm:chararray,
soarbu_no_nm:chararray,
KsnDesc:chararray,
tag_id:chararray,
tag_date:chararray,
tag_name:chararray,
tagdesc:chararray,
tag_url:chararray,
image_url:chararray,
tag_type:chararray,
ctg_name:chararray,
ctg_date:chararray,
ctg_desc:chararray,
ownder_id:chararray,
privacy:chararray,
type_cd:chararray,
ctg_url:chararray,
cover_image_url:chararray,
followers:chararray,
likes:chararray);

foreach_file = foreach load_file generate syw_member_id,intractdatetime,soar_nm,tag_name,ctg_name,interaction_type;

filter_file_365 = filter foreach_file by SUBSTRING(intractdatetime,0,10) >= '$set365days' and SUBSTRING(intractdatetime,0,10) <= '$setdt';

foreach_file_365 = foreach filter_file_365 generate syw_member_id,soar_nm,tag_name,ctg_name,interaction_type;

store foreach_file_365 into '$MADE_WORK_DIR/syw/SywIntrctns/sywInteractionsMemberProduct365' using PigStorage('\t');

filter_file_7 = filter foreach_file by SUBSTRING(intractdatetime,0,10) >= '$set7days' AND SUBSTRING(intractdatetime,0,10) <= '$setdt';

foreach_file_7 = foreach filter_file_7 generate syw_member_id,soar_nm,tag_name,ctg_name,interaction_type;

store foreach_file_7 into '$MADE_WORK_DIR/syw/SywIntrctns/sywInteractionsMemberProduct7' using PigStorage('\t');
