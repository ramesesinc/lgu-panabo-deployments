-- 
-- NOTE: Please use Navicat in running the scripts below
-- 
-- 1. Connect to ETRACS main database 
-- 2. Execute the following scripts below: 
--
alter table account_incometarget add CONSTRAINT `fk_account_incometarget_itemid` 
	FOREIGN KEY (`itemid`) REFERENCES `account` (`objid`)
;


CREATE TABLE `cashreceipt_group` ( 
   `objid` varchar(50) NOT NULL, 
   `txndate` datetime NOT NULL, 
   `controlid` varchar(50) NOT NULL, 
   `amount` decimal(16,2) NOT NULL, 
   `totalcash` decimal(16,2) NOT NULL, 
   `totalnoncash` decimal(16,2) NOT NULL, 
   `cashchange` decimal(16,2) NOT NULL,
   CONSTRAINT `pk_cashreceipt_group` PRIMARY KEY (`objid`),
   KEY `ix_controlid` (`controlid`),
   KEY `ix_txndate` (`txndate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 


CREATE TABLE `cashreceipt_groupitem` ( 
   `objid` varchar(50) NOT NULL, 
   `parentid` varchar(50) NOT NULL,
   CONSTRAINT `pk_cashreceipt_groupitem` PRIMARY KEY (`objid`),
   KEY `ix_parentid` (`parentid`),
   CONSTRAINT `fk_cashreceipt_groupitem_objid` FOREIGN KEY (`objid`) REFERENCES `cashreceipt` (`objid`),
   CONSTRAINT `fk_cashreceipt_groupitem_parentid` FOREIGN KEY (`parentid`) REFERENCES `cashreceipt_group` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 

CREATE TABLE `cashreceipt_plugin` ( 
   `objid` varchar(50) NOT NULL, 
   `connection` varchar(150) NOT NULL, 
   `servicename` varchar(255) NOT NULL,
   CONSTRAINT `pk_cashreceipt_plugin` PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 


alter table collectiontype add info text null 
; 

CREATE TABLE `entity_mapping` ( 
   `objid` varchar(50) NOT NULL, 
   `parent_objid` varchar(50) NOT NULL, 
   `org_objid` varchar(50) NULL,
   CONSTRAINT `pk_entity_mapping` PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 


DROP TABLE IF EXISTS `paymentorder`
;
CREATE TABLE `paymentorder` (
   `objid` varchar(50) NOT NULL, 
   `txndate` datetime NULL, 
   `payer_objid` varchar(50) NULL, 
   `payer_name` text NULL, 
   `paidby` text NULL, 
   `paidbyaddress` varchar(150) NULL, 
   `particulars` text NULL, 
   `amount` decimal(16,2) NULL, 
   `txntype` varchar(50) NULL, 
   `expirydate` date NULL, 
   `refid` varchar(50) NULL, 
   `refno` varchar(50) NULL, 
   `info` text NULL, 
   `txntypename` varchar(255) NULL, 
   `locationid` varchar(50) NULL, 
   `origin` varchar(50) NULL, 
   `issuedby_objid` varchar(50) NULL, 
   `issuedby_name` varchar(150) NULL, 
   `org_objid` varchar(50) NULL, 
   `org_name` varchar(255) NULL, 
   `items` text NULL, 
   `collectiontypeid` varchar(50) NULL, 
   `queueid` varchar(50) NULL,
   CONSTRAINT `pk_paymentorder` PRIMARY KEY (`objid`),
   KEY `ix_collectiontypeid` (`collectiontypeid`),
   KEY `ix_issuedby_name` (`issuedby_name`),
   KEY `ix_issuedby_objid` (`issuedby_objid`),
   KEY `ix_locationid` (`locationid`),
   KEY `ix_org_name` (`org_name`),
   KEY `ix_org_objid` (`org_objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 
