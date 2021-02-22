package bpls.actions;

import com.rameses.rules.common.*;
import bpls.facts.*;
import com.rameses.util.*;

public class SetupInterestAccount implements RuleActionHandler {
	
	def request;
	def BA;

	public void execute(def params, def drools) {
		def sa = params.account;	
		def pmt = params.payment;
		def lob = params.lob;

		def acct = BA.findAccount( [objid: sa.key] );
		def amt = pmt.interest;
		def key = [account: acct];
		if(lob) {
			key.lob = [objid: lob.objid, name: lob.name];
		}	

		def acctMap = request.accounts;
		def val = acctMap.get(key);
		if(!val) {
			val = [:];	
			val.amount = 0;
			if(lob) {
				val.lob = [objid: lob.objid, name: lob.name];
				val.remarks = val.lob.name;				
			}	
			val.item = acct;
			val.sortorder = 5;
			val.txntype = 'interest'
			acctMap.put( key, val);
		}	
		val.amount = NumberUtil.round(val.amount + amt);
	}

}