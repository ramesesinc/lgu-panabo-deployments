INSERT IGNORE INTO sys_usergroup (objid, title, domain, userclass, orgclass, role) 
VALUES ('RULEMGMT.DEV', 'RULEMGMT DEVELOPER', 'RULEMGMT', 'usergroup', NULL, 'DEV');

update sys_usergroup_permission set usergroup_objid='RULEMGMT.DEV' where usergroup_objid = 'RULEMGMT.MASTER'
;
update sys_usergroup_member set usergroup_objid='RULEMGMT.DEV' where usergroup_objid = 'RULEMGMT.MASTER'
;
delete from sys_usergroup where objid = 'RULEMGMT.MASTER'
; 


INSERT IGNORE INTO sys_usergroup (objid, title, domain, userclass, orgclass, role) 
VALUES ('WORKFLOW.DEV', 'WORKFLOW DEVELOPER', 'WORKFLOW', 'usergroup', NULL, 'DEV');

update sys_usergroup_permission set usergroup_objid='WORKFLOW.DEV' where usergroup_objid = 'WORKFLOW.MASTER'
;
update sys_usergroup_member set usergroup_objid='WORKFLOW.DEV' where usergroup_objid = 'WORKFLOW.MASTER'
;
delete from sys_usergroup where objid = 'WORKFLOW.MASTER'
; 
