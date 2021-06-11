ALTER SESSION SET CONTAINER=ORCLPDB1;
create user jiradbuser identified by pass default tablespace users quota unlimited on users;
grant connect to jiradbuser;
grant create table to jiradbuser;
grant create sequence to jiradbuser;
grant create trigger to jiradbuser;
