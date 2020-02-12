drop view if exists vw_income_summary
; 
create view vw_income_summary as 
select 
  inc.*, fund.groupid as fundgroupid, 
  ia.objid as itemid, ia.code as itemcode, ia.title as itemtitle, ia.type as itemtype  
from income_summary inc 
  inner join fund on fund.objid = inc.fundid 
  inner join itemaccount ia on ia.objid = inc.acctid 
;