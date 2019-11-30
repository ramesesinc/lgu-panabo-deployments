[getList]
select * from checkissuance
where state like $P{state} AND bank_objid LIKE $P{bankid} AND fund_code LIKE $P{fundcode} AND payee_name like $P{searchtext}
order by checkdate DESC