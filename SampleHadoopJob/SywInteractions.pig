SET DEFAULT_PARALLEL 20;

REGISTER '/home/auto/vsithan/ValidateDate.jar';

REGISTER '/home/auto/vsithan/ConcatData.jar';

interactions = LOAD '/smith/analytics/sywcom_t/intract' using PigStorage('\\u0001') as
(
  download_tmp : chararray,
  interaction_id  :chararray,
  interaction_date :chararray,
  interaction_type :chararray,
  syw_user_id  :chararray
);

foreach_interactions = FOREACH interactions GENERATE interaction_id,interaction_date,interaction_type,syw_user_id;

members = LOAD '/smith/analytics/sywcom_t/mbr' using PigStorage('\\u0001') as
(
  download_tmp : chararray,
  syw_user_id   :chararray,
  fname_lname   :chararray,
  syw_member_id :chararray,
  sears_id      :chararray
);

foreach_members = FOREACH members GENERATE syw_user_id,syw_member_id;

prod_attr = LOAD '/smith/analytics/sywcom_t/prodattr' using PigStorage('\\u0001') as
(
  download_tmp : chararray,
  interaction_id :chararray,
  division : chararray,
  item : chararray,
  ksn : chararray
);

foreach_prod_attr = FOREACH prod_attr GENERATE interaction_id,division,item,ksn;

foreach_case_prod_attr = foreach foreach_prod_attr generate 
interaction_id,
(CASE division WHEN '-1' THEN '' ELSE division END) as division,
(CASE item WHEN '-1' THEN '' ELSE item END) as item,
(CASE ksn WHEN '-1' THEN '' ELSE ksn END) as ksn;

sears_bu = LOAD '/smith/analytics/sywcom_t/sears' using PigStorage('\\u0001') as 
(
	download_tmp : chararray,
	itm_no	:chararray	,
	div_no	:chararray	,
	div_nm	:chararray	,
	soar_no	:chararray	,
	soar_nm	:chararray	,
	ln_no	:chararray	,
	ln_ds	:chararray	,
	sbl_no	:chararray	,
	sbl_ds	:chararray	,
	prd_ds	:chararray 
);

foreach_sears_bu = FOREACH sears_bu GENERATE itm_no,div_no,soar_no,soar_nm,prd_ds;


kmart_bu = LOAD '/smith/analytics/sywcom_t/kmt' using PigStorage('\\u0001') as 
(
	download_tmp : chararray,
	SoarBuNbr :chararray,
	SoarBuNm  :chararray,
	KsnId     :chararray,
	KsnDesc   :chararray
);

foreach_kmart_bu = FOREACH kmart_bu GENERATE SoarBuNbr,SoarBuNm,KsnId,KsnDesc;


tag_model = LOAD '/smith/analytics/sywcom_t/tag' using PigStorage('\\u0001') as
(
	download_tmp          :chararray,
	interaction_id        :chararray,
	tag_id                :chararray,
	create_date           :chararray,
	name                  :chararray,
	description           :chararray,
	url                   :chararray,
	image_url             :chararray,
	tag_type              :chararray
);

foreach_tag_model = FOREACH tag_model GENERATE interaction_id,tag_id,create_date,name,description,url,image_url,tag_type;

catalog_model = LOAD '/smith/analytics/sywcom_t/ctg' using PigStorage ('\\u0001') as
(

       download_tmp           :chararray,
       interaction_id         :chararray,
       catalog_id             :chararray,
       create_date            :chararray,
       updated_date           :chararray,
       description            :chararray,
       name                   :chararray,
       owner_id               :chararray,
       privacy                :chararray,
       type_cd                :chararray,
       url                    :chararray,
       cover_image_url        :chararray,
       followers              :chararray,
       likes                  :chararray 
);

foreach_catalog_model = FOREACH catalog_model GENERATE interaction_id,catalog_id,create_date,description,name,owner_id,privacy,type_cd,url,cover_image_url,
followers,likes;

int_members = JOIN foreach_members  by syw_user_id , foreach_interactions  by syw_user_id;

int_members_syw = FILTER int_members by syw_member_id is not null;

int_mem_prod = JOIN int_members_syw by interaction_id LEFT OUTER, foreach_case_prod_attr by interaction_id;

all_int = FOREACH int_mem_prod GENERATE 
foreach_members::syw_member_id, 
org.sears.validatedate.ValidateDate(foreach_interactions::interaction_date) as date_time,
foreach_members::syw_user_id, 
foreach_interactions::interaction_id, 
foreach_interactions::interaction_type, 
foreach_case_prod_attr::division,
foreach_case_prod_attr::item,
foreach_case_prod_attr::ksn;

srs_data = FILTER all_int by foreach_case_prod_attr::item != '';

kmt_data = FILTER all_int by (foreach_case_prod_attr::item =='' or foreach_case_prod_attr::item is null);

int_srs = JOIN srs_data by (division, item) LEFT OUTER, foreach_sears_bu by (div_no, itm_no);

int_srs_tag = JOIN int_srs by (foreach_interactions::interaction_id) LEFT OUTER, foreach_tag_model by (interaction_id);

int_srs_catalog = JOIN int_srs_tag by (foreach_interactions::interaction_id) LEFT OUTER, foreach_catalog_model by (interaction_id);

foreach_file_srs_datecheck = foreach int_srs_catalog generate
foreach_members::syw_member_id as srs_syw_member_id,
srs_data::date_time as srs_date_time,
foreach_members::syw_user_id as srs_syw_user_id,
foreach_interactions::interaction_id  as srs_interaction_id,
foreach_interactions::interaction_type as srs_interaction_type,
(CASE foreach_case_prod_attr::division WHEN '' THEN null ELSE foreach_case_prod_attr::division END) as srs_division,
(CASE foreach_case_prod_attr::item WHEN '' THEN null ELSE foreach_case_prod_attr::item END) as srs_item,
(CASE foreach_case_prod_attr::ksn WHEN '' THEN null ELSE foreach_case_prod_attr::ksn END) as srs_ksn,
foreach_sears_bu::soar_no as srs_soar_no,
foreach_sears_bu::soar_nm as srs_soar_nm,
foreach_sears_bu::prd_ds as srs_prd_ds,
foreach_tag_model::tag_id as srs_tag_id,
org.sears.validatedate.ValidateDate(foreach_tag_model::create_date) as srs_tag_date,
foreach_tag_model::name as srs_tag_name,
foreach_tag_model::description as srs_description,
foreach_tag_model::url as srs_tag_url,
foreach_tag_model::image_url as srs_tag_image_url,
foreach_tag_model::tag_type as srs_tag_type,
foreach_catalog_model::name as srs_ctg_name,
org.sears.validatedate.ValidateDate(foreach_catalog_model::create_date) as srs_ctg_date,
foreach_catalog_model::description as srs_desc,
foreach_catalog_model::owner_id  as srs_owner_id,
foreach_catalog_model::privacy as srs_privacy,
foreach_catalog_model::type_cd as srs_type_cd,
foreach_catalog_model::url as srs_ctg_url,
foreach_catalog_model::cover_image_url as srs_cover_image_url,
foreach_catalog_model::followers as srs_followers,
foreach_catalog_model::likes as srs_likes;


foreach_file_srs = foreach foreach_file_srs_datecheck generate
srs_syw_member_id,
CONCAT(SUBSTRING(srs_date_time, 0, 10), 'T00:00:00Z') as date_time, 
srs_syw_user_id,
srs_interaction_id,
srs_interaction_type,
srs_division,
srs_item,
srs_ksn,
srs_soar_no,
srs_soar_nm,
org.sears.concat.Concat(srs_soar_no,srs_soar_nm) as srs_soar_no_nm,
srs_prd_ds,
srs_tag_id,
CONCAT(CONCAT(SUBSTRING(srs_tag_date,0,10),'T'),CONCAT(SUBSTRING(srs_tag_date,11,19),'Z')),
srs_tag_name,
srs_description,
srs_tag_url,
srs_tag_image_url,
srs_tag_type,
srs_ctg_name,
CONCAT(CONCAT(SUBSTRING(srs_ctg_date, 0,10),'T'),CONCAT(SUBSTRING(srs_ctg_date,11,19),'Z')),
srs_desc,
srs_owner_id,
srs_privacy,
srs_type_cd,
srs_ctg_url,
srs_cover_image_url,
srs_followers,
srs_likes;

int_kmt = JOIN kmt_data by (ksn) LEFT OUTER, foreach_kmart_bu by (KsnId);

int_kmt_tag = JOIN int_kmt by (foreach_interactions::interaction_id) LEFT OUTER, foreach_tag_model by (interaction_id);

int_kmt_catalog = JOIN int_kmt_tag by (foreach_interactions::interaction_id) LEFT OUTER, foreach_catalog_model by (interaction_id);

foreach_file_kmt_datecheck = foreach int_kmt_catalog generate	
foreach_members::syw_member_id as kmt_syw_member_id,
kmt_data::date_time as kmt_date_time,
foreach_members::syw_user_id as kmt_syw_user_id,
foreach_interactions::interaction_id as kmt_interaction_id,
foreach_interactions::interaction_type as kmt_interaction_type,
(CASE foreach_case_prod_attr::division WHEN '' THEN null ELSE foreach_case_prod_attr::division END) as kmt_division,
(CASE foreach_case_prod_attr::item WHEN '' THEN null ELSE foreach_case_prod_attr::item END) as kmt_item,
(CASE foreach_case_prod_attr::ksn WHEN '' THEN null ELSE foreach_case_prod_attr::ksn END) as kmt_ksn,
foreach_kmart_bu::SoarBuNbr as kmt_SoarBuNbr,
foreach_kmart_bu::SoarBuNm as kmt_SoarBuNm,
foreach_kmart_bu::KsnDesc as kmt_KsnDesc,
foreach_tag_model::tag_id as kmt_tag_id,
org.sears.validatedate.ValidateDate(foreach_tag_model::create_date) as kmt_tag_date,
foreach_tag_model::name as kmt_tag_name,
foreach_tag_model::description as kmt_desc,
foreach_tag_model::url as kmt_tag_url,
foreach_tag_model::image_url as kmt_image_url,
foreach_tag_model::tag_type as kmt_tag_type,
foreach_catalog_model::name as kmt_ctg_name,
org.sears.validatedate.ValidateDate(foreach_catalog_model::create_date) as kmt_ctg_date,
foreach_catalog_model::description as kmt_ctg_desc,
foreach_catalog_model::owner_id as kmt_ownder_id,
foreach_catalog_model::privacy as kmt_privacy,
foreach_catalog_model::type_cd as kmt_type_cd,
foreach_catalog_model::url as kmt_ctg_url,
foreach_catalog_model::cover_image_url as kmt_cover_image_url,
foreach_catalog_model::followers as kmt_followers,
foreach_catalog_model::likes as kmt_likes;

foreach_file_kmt = foreach foreach_file_kmt_datecheck generate
kmt_syw_member_id,
CONCAT(SUBSTRING(kmt_date_time, 0, 10), 'T00:00:00Z') as date_time,
kmt_syw_user_id,
kmt_interaction_id,
kmt_interaction_type,
kmt_division,
kmt_item,
kmt_ksn,
kmt_SoarBuNbr,
kmt_SoarBuNm,
org.sears.concat.Concat(kmt_SoarBuNbr,kmt_SoarBuNm) as kmt_soarbu_no_nm,
kmt_KsnDesc,
kmt_tag_id,
CONCAT(CONCAT(SUBSTRING(kmt_tag_date, 0,10),'T'),CONCAT(SUBSTRING(kmt_tag_date,11,19),'Z')),
kmt_tag_name,
kmt_desc,
kmt_tag_url,
kmt_image_url,
kmt_tag_type,
kmt_ctg_name,
CONCAT(CONCAT(SUBSTRING(kmt_ctg_date, 0,10),'T'),CONCAT(SUBSTRING(kmt_ctg_date,11,19),'Z')),
kmt_ctg_desc,
kmt_ownder_id,
kmt_privacy,
kmt_type_cd,
kmt_ctg_url,
kmt_cover_image_url,
kmt_followers,
kmt_likes;

union_data = UNION foreach_file_srs,foreach_file_kmt;

STORE union_data into '/smith/analytics/sywcom_t/sywInteractionsMemberProduct' using PigStorage('\t');
