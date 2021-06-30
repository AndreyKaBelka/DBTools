FROM atlassian/jira-software:${JIRA_VERSION}

COPY ./drivers/ /opt/atlassian/jira/lib/
