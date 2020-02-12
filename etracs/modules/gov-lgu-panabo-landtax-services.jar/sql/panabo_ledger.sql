[approveLedgerFaasByLedgerId]
update rptledgerfaas set state = 'APPROVED' where rptledgerid = $P{objid}
	