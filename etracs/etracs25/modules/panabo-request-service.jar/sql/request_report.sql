[getList]
select * from request
where subject LIKE $P{params} OR
description LIKE $P{params} OR
actionTaken LIKE $P{params} OR
status LIKE $P{params}
order by subject