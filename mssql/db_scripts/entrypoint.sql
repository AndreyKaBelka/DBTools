CREATE DATABASE jiradb COLLATE SQL_Latin1_General_CP437_CI_AI;
GO
USE master;
GO
CREATE LOGIN jiradbuser WITH PASSWORD = N'SuperStrong123!', DEFAULT_DATABASE=[master];
GO
USE jiradb;
GO
CREATE USER jiradbuser FOR LOGIN jiradbuser;
GO
ALTER ROLE db_owner ADD MEMBER jiradbuser;
GO
CREATE SCHEMA jiraschema AUTHORIZATION jiradbuser;
GO
ALTER USER jiradbuser WITH DEFAULT_SCHEMA = jiraschema;
GO
GRANT SELECT ON jiradb TO jiradbuser;
GRANT INSERT ON jiradb TO jiradbuser;
GRANT UPDATE ON jiradb TO jiradbuser;
GRANT DELETE ON jiradb TO jiradbuser;
GO
SET NOCOUNT OFF;
GO
ALTER DATABASE jiradb SET READ_COMMITTED_SNAPSHOT ON;
GO
USE [master]
GO
EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'LoginMode', REG_DWORD, 2
GO