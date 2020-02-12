
alter table paymentorder 
	change txntypeid txntype varchar(50) null 
; 
alter table paymentorder  add (
	txntypename varchar(255) null, 
	locationid varchar(50) null, 
	origin varchar(50) null, 
	issuedby_objid varchar(50) null, 
	issuedby_name varchar(150) null, 
	org_objid varchar(50) null, 
	org_name varchar(255) null, 
	items text null, 
	collectiontypeid varchar(50) null, 
	queueid varchar(50) null 
)
;
create index ix_collectiontypeid on paymentorder (collectiontypeid)
;
create index ix_locationid on paymentorder (locationid)
;
create index ix_issuedby_objid on paymentorder (issuedby_objid)
;
create index ix_issuedby_name on paymentorder (issuedby_name)
;
create index ix_org_objid on paymentorder (org_objid)
;
create index ix_org_name on paymentorder (org_name)
;

alter table paymentorder drop primary key 
;
alter table paymentorder change txnid objid varchar(50) not null 
;
alter table paymentorder add constraint pk_paymentorder primary key (objid)
;



drop table if exists sync_data_forprocess;
drop table if exists sync_data_pending;
drop table if exists sync_data;

CREATE TABLE `sync_data` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) NOT NULL,
  `refid` varchar(50) NOT NULL,
  `reftype` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `orgid` varchar(50) DEFAULT NULL,
  `remote_orgid` varchar(50) DEFAULT NULL,
  `remote_orgcode` varchar(20) DEFAULT NULL,
  `remote_orgclass` varchar(20) DEFAULT NULL,
  `dtfiled` datetime NOT NULL,
  `idx` int(11) NOT NULL,
  `sender_objid` varchar(50) DEFAULT NULL,
  `sender_name` varchar(150) DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_sync_data_refid` (`refid`),
  KEY `ix_sync_data_reftype` (`reftype`),
  KEY `ix_sync_data_orgid` (`orgid`),
  KEY `ix_sync_data_dtfiled` (`dtfiled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `sync_data_pending` (
  `objid` varchar(50) NOT NULL,
  `error` text,
  `expirydate` datetime DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_expirydate` (`expirydate`),
  CONSTRAINT `fk_sync_data_pending_sync_data` FOREIGN KEY (`objid`) REFERENCES `sync_data` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `sync_data_forprocess` (
  `objid` varchar(50) NOT NULL,
  PRIMARY KEY (`objid`),
  CONSTRAINT `fk_sync_data_forprocess_sync_data` FOREIGN KEY (`objid`) REFERENCES `sync_data` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;




CREATE TABLE `cashreceipt_plugin` (
  `objid` varchar(50) NOT NULL,
  `connection` varchar(150) NOT NULL,
  `servicename` varchar(255) NOT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;


