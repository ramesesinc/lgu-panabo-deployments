[getList]
select * from checkissuance
where bank_code like $P{bankcode} AND checkdate <= $P{searchtext} AND createdby_name like $P{createdbyname}