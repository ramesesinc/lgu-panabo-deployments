CREATE TABLE [online_business_application] (
  [objid] varchar(50) NOT NULL,
  [state] varchar(20) NOT NULL,
  [dtcreated] datetime NOT NULL,
  [createdby_objid] varchar(50) NOT NULL,
  [createdby_name] varchar(100) NOT NULL,
  [controlno] varchar(25) NOT NULL,
  [prevapplicationid] varchar(50) NOT NULL,
  [business_objid] varchar(50) NOT NULL,
  [appyear] int NOT NULL,
  [apptype] varchar(20) NOT NULL,
  [appdate] date NOT NULL,
  [lobs] text NOT NULL,
  [infos] varchar(MAX) NOT NULL,
  [requirements] varchar(MAX) NOT NULL,
  [step] int NOT NULL DEFAULT '0',
  [dtapproved] datetime DEFAULT NULL,
  [approvedby_objid] varchar(50) DEFAULT NULL,
  [approvedby_name] varchar(150) DEFAULT NULL,
  [approvedappno] varchar(25) DEFAULT NULL,
  constraint pk_online_business_application PRIMARY KEY ([objid])
) ENGINE=InnoDB DEFAULT CHARSET=utf8
go
create index [ix_state] on online_business_application ([state])
go
create index [ix_dtcreated] on online_business_application ([dtcreated])
go
create index [ix_controlno] on online_business_application ([controlno])
go
create index [ix_prevapplicationid] on online_business_application ([prevapplicationid])
go
create index [ix_business_objid] on online_business_application ([business_objid])
go
create index [ix_appyear] on online_business_application ([appyear])
go
create index [ix_appdate] on online_business_application ([appdate])
go
create index [ix_dtapproved] on online_business_application ([dtapproved])
go
create index [ix_approvedby_objid] on online_business_application ([approvedby_objid])
go
create index [ix_approvedby_name] on online_business_application ([approvedby_name])
go
alter table online_business_application add CONSTRAINT [fk_online_business_application_business_objid] 
  FOREIGN KEY ([business_objid]) REFERENCES [business] ([objid])
go
alter table online_business_application add CONSTRAINT [fk_online_business_application_prevapplicationid] 
  FOREIGN KEY ([prevapplicationid]) REFERENCES [business_application] ([objid])
go
