[getApplicationInfos]
select 
	xx.activeyear, xx.businessid, xx.essential, xx.lobid, xx.lobname, 
	sum(xx.capital) as capital, sum(xx.gross) as gross, 
	sum(xx.grossessential) as grossessential, 
	sum(xx.grossnonessential) as grossnonessential 
from ( 
	select xx.*, lob.name as lobname, 
		(case when bai.attribute_objid='CAPITAL' then bai.decimalvalue else null end) as capital, 
		(case when bai.attribute_objid='GROSS' then bai.decimalvalue else null end) as gross,
		(case when bai.attribute_objid='GROSS' and xx.essential>0 then bai.decimalvalue else null end) as grossessential, 
		(case when bai.attribute_objid='GROSS' and xx.essential<=0 then bai.decimalvalue else null end) as grossnonessential
	from ( 
		select bal.*, 
			(select count(*) from lob_lobattribute where lobid=bal.lobid and lobattributeid='ESSENTIAL') as essential 
		from ( 
			select 
				bal.businessid, bal.activeyear, bal.lobid, max(ba.txndate) as txndate 
			from business_application x 
				inner join business_application_lob bal on (x.business_objid=bal.businessid and x.appyear=bal.activeyear) 
				inner join business_application ba on bal.applicationid=ba.objid 
			where x.objid=$P{applicationid} 
			group by bal.businessid, bal.activeyear, bal.lobid 
		)xx 
			inner join business_application_lob bal on xx.businessid=bal.businessid 
			inner join business_application ba on bal.applicationid=ba.objid 
		where bal.activeyear=xx.activeyear 
			and bal.lobid=xx.lobid 
			and ba.txndate=xx.txndate 
			and bal.assessmenttype in ('NEW','RENEW') 
	)xx 
		inner join business_application_info bai on xx.applicationid=bai.applicationid 
		inner join lob on bai.lob_objid=lob.objid 
	where bai.lob_objid=xx.lobid 
)xx 
group by 
	xx.activeyear, xx.businessid, xx.essential, xx.lobid, xx.lobname 


[getApplicationTaxFees]
select 
	xx.businessid, xx.activeyear, xx.lobid, xx.lobname, 
	sum(xx.tax) as tax, sum(xx.mp) as mp 
from ( 
	select 
		xx.businessid, xx.activeyear, xx.lobid, lob.name as lobname, 
		(case when br.taxfeetype='TAX' then br.amount else 0.0 end) as tax, 
		(
			select br.amount from itemaccount_tag a 
			where a.acctid=br.account_objid and a.tag='MP' and br.taxfeetype='REGFEE' 
		) as mp 
	from ( 
		select bal.* from ( 
			select 
				bal.businessid, bal.activeyear, bal.lobid, max(ba.txndate) as txndate 
			from business_application x 
				inner join business_application_lob bal on (x.business_objid=bal.businessid and x.appyear=bal.activeyear) 
				inner join business_application ba on bal.applicationid=ba.objid 
			where x.objid=$P{applicationid} 
			group by bal.businessid, bal.activeyear, bal.lobid 
		)xx 
			inner join business_application_lob bal on xx.businessid=bal.businessid 
			inner join business_application ba on bal.applicationid=ba.objid 
		where bal.activeyear=xx.activeyear 
			and bal.lobid=xx.lobid 
			and ba.txndate=xx.txndate 
			and bal.assessmenttype in ('NEW','RENEW') 
	)xx 
		inner join business_receivable br on xx.applicationid=br.applicationid 
		inner join lob on xx.lobid=lob.objid 
	where br.lob_objid=xx.lobid and br.iyear=xx.activeyear 
)xx 
group by xx.businessid, xx.activeyear, xx.lobid, xx.lobname 


[findGrossCapital]
select 
	xx.businessid, xx.activeyear, sum(xx.capital) as capital, sum(xx.gross) as gross, 
	sum(xx.declaredcapital) as declaredcapital, sum(xx.declaredgross) as declaredgross 
from ( 
	select 
		xx.businessid, xx.activeyear, 
		(case when bai.attribute_objid='CAPITAL' then bai.decimalvalue else 0.0 end) as capital, 
		(case when bai.attribute_objid='GROSS' then bai.decimalvalue else 0.0 end) as gross, 
		(case when bai.attribute_objid='DECLARED_CAPITAL' then bai.decimalvalue else 0.0 end) as declaredcapital, 
		(case when bai.attribute_objid='DECLARED_GROSS' then bai.decimalvalue else 0.0 end) as declaredgross
	from ( 	
			select bal.* 
			from ( 
				select 
					bal.businessid, bal.activeyear, bal.lobid, max(ba.txndate) as txndate, 
					(select count(*) from lob_lobattribute where lobid=bal.lobid and lobattributeid='ESSENTIAL') as essential 
				from business_application x 
					inner join business_application_lob bal on (x.business_objid=bal.businessid and x.appyear=bal.activeyear) 
					inner join business_application ba on bal.applicationid=ba.objid 
				where x.objid=$P{applicationid} 
					and ba.state='COMPLETED' 
				group by bal.businessid, bal.activeyear, bal.lobid 
			)xx 
				inner join business_application_lob bal on xx.businessid=bal.businessid 
				inner join business_application ba on bal.applicationid=ba.objid 
			where bal.activeyear=xx.activeyear 
				and bal.lobid=xx.lobid 
				and ba.txndate=xx.txndate 
				and bal.assessmenttype in ('NEW','RENEW') 
	)xx 
		inner join business_application_info bai on bai.applicationid=xx.applicationid 
	where bai.lob_objid = xx.lobid 
)xx 
group by xx.businessid, xx.activeyear 
