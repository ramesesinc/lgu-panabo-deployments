[findProperty]
select idmaster, rp_ctrl as rpctrl 
from rptas.aarpta1 
where idmaster = $P{idmaster}


[getCredits]
select 
	c.collect_id as objid,
	'SYSTEM' as type,
	c.or_no as refno,
	c.or_date as refdate,
	null as payorid,
	c.payor as paidby_name,
	'-' as paidby_address,
	'-' as collector,
	'system' as postedby,
	'system' as postedbytitle,
	c.or_date as dtposted,
	min(cb.yr) as fromyear,
	min(case when cb.qtr = 0 then 1 else cb.qtr end) as fromqtr,
	max(cb.yr) as toyear,
	max( case when cb.qtr = 0 then 4 else cb.qtr end) as toqtr,
	sum(cb.basic) as basic,
	sum(cb.basicint) as basicint,
	sum(cb.basicdisc) as basicdisc,
	0.0 as basicidle,
	sum(cs.sef) as sef,
	sum(cs.sefint) as sefint,
	sum(cs.sefdisc) as sefdisc,
	0.0 as firecode,
	sum(cb.basic - cb.basicdisc + cb.basicint + cs.sef - cs.sefdisc + cs.sefint) as amount,
	null as collectingagency
from rptnew.collect1 c
	inner join rptnew.xcolbsc cb on c.collect_id = cb.collect_id
  inner join rptnew.xcolsef cs on c.collect_id = cs.collect_id
where c.rp_ctrl = $P{rpctrl}
 and cb.yr = cs.yr and cb.qtr = cs.qtr
group by 
	c.collect_id,	c.or_no, c.or_date, c.payor
order by cb.yr desc, cb.qtr desc 

[getFaasHistories]
select 
	p.unik as objid,
	'PENDING' as state,
	p.tdn as tdno,
	0 as backtax,
	year(p.effect) as fromyear,
	1 as fromqtr, 
	p.asd_val as assessedvalue,
	0 as systemcreated,
	0 as reclassed,
	0 as idleland
from rptnew.td_prop p 
where p.rp_ctrl =  $P{rpctrl}
order by p.effect desc 