CREATE USER jiradbuser@'jira-db-test.mysql_jira-bridge' IDENTIFIED BY 'pass';
CREATE DATABASE jiradb CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,REFERENCES,ALTER,INDEX on jiradb.* TO jiradbuser@'jira-db-test.mysql_jira-bridge';
flush privileges;