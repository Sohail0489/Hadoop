load_365_type = load '$MADE_WORK_DIR/syw/SywIntrctns/sywInteractionsMemberProduct365type' using PigStorage('\t') as (lyltycardnbr:chararray,interactionstype365);

load_365_detail = load '$MADE_WORK_DIR/syw/SywIntrctns/sywInteractionsMemberProduct365typedetail' using PigStorage('\t') as (lyltycardnbr:chararray,interactionsdetail365);

join_365 = join load_365_type by lyltycardnbr, load_365_detail by lyltycardnbr;

load_7_type = load '$MADE_WORK_DIR/syw/SywIntrctns/sywInteractionsMemberProduct7type' using PigStorage('\t') as (lyltycardnbr:chararray,interactionstype7);

load_7_detail = load '$MADE_WORK_DIR/syw/SywIntrctns/sywInteractionsMemberProduct7typedetail' using PigStorage('\t') as (lyltycardnbr:chararray,interactionsdetail7);

join_7 = join load_7_type by lyltycardnbr, load_7_detail by lyltycardnbr;

join_files = join join_365 by load_365_detail::lyltycardnbr left outer, join_7 by load_7_detail::lyltycardnbr;

final_file = foreach join_files generate 
load_365_detail::lyltycardnbr,
load_7_type::interactionstype7,
load_7_detail::interactionsdetail7,
load_365_type::interactionstype365,
load_365_detail::interactionsdetail365;

store final_file into '$MADE_WORK_DIR/syw/SywIntrctns/sywintrctns_transform' using PigStorage('\t');
