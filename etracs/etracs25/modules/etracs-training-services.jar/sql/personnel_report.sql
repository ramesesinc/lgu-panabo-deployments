[getList]
select * from personnel
where lastname like $P{lastname}
order by idno