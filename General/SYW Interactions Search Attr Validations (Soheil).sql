
/**************************************************************
TERADATA SOURCE
**************************************************************/

show view L2_SelfServAnlysEngineDev_S.SywIntractn
;show view L2_SelfServAnlysEngineDev.SywMbr
;show view L2_SelfServAnlysEngineDev_S.SywTag
;show view L2_SelfServAnlysEngineDev_S.SywProdAttr
;show view L2_SelfServAnlysEngineDev_S.SywCtlg

	
	
	L2_SelfServAnlysEngineDev_T.SrsSoarBu
	>> compare Div and Itm
	
	L2_SelfServAnlysEngineDev_T.KmtSoarBu
	>> compare Ksn



replace  VIEW L2_SelfServAnlysEngineDev_S.SywIntractn
AS LOCK ROW FOR ACCESS
SELECT
      INTERACTION_ID as IntractnId,
      DATE_TIME as DtTm,
      INTERACTION_TYPE as IntractnTypeCd,
      SYW_USER_ID as SywUserId
FROM SYWCom_T.t_score_interactions;




sel count(*) , count (distinct SywMbrId), count (distinct I.IntractnId)
from
(sel I.IntractnId, SywMbrId from L2_SelfServAnlysEngineDev.SywIntractn I
, L2_SelfServAnlysEngineDev.SywMbr M
where I.SywUserId = M.SywUserId
and M.SywMbrId is not null
) I

LEFT OUTER JOIN 
L2_SelfServAnlysEngineDev.SywProdAttr P
ON I.IntractnId=P.IntractnId


LEFT OUTER JOIN 
L2_SelfServAnlysEngineDev.SywTag T
ON I.IntractnId= T.IntractnId

LEFT OUTER JOIN 
L2_SelfServAnlysEngineDev.SywCtlg C
ON I.IntractnId= C.IntractnId
;

/**************************************************************
HIVE TABLE

http://151.149.131.21:8888/
**************************************************************/

map_impala_poc.sywinteractions


/**************************************************************
VALIDATIONS
**************************************************************/

sel IntractnTypeCd, count(*)
from
(sel I.* ,  M.SywMbrId  from L2_SelfServAnlysEngineDev.SywIntractn I
, L2_SelfServAnlysEngineDev.SywMbr M
where I.SywUserId = M.SywUserId
and M.SywMbrId is not null
) I

LEFT OUTER JOIN 
L2_SelfServAnlysEngineDev.SywProdAttr P
ON I.IntractnId=P.IntractnId


LEFT OUTER JOIN 
L2_SelfServAnlysEngineDev.SywTag T
ON I.IntractnId= T.IntractnId

LEFT OUTER JOIN 
L2_SelfServAnlysEngineDev.SywCtlg C
ON I.IntractnId= C.IntractnId

group by 1