ARG JIRA_VERSION
ARG PORT
FROM atlassian/jira-software:$JIRA_VERSION

COPY ./drivers/mysql-connector-java-8.0.25.jar /opt/atlassian/jira/lib/
COPY ./drivers/ojdbc7.jar /opt/atlassian/jira/lib/
COPY ./drivers/ojdbc8.jar /opt/atlassian/jira/lib/
COPY ./wait-for-it.sh /home
RUN chmod +x /home/wait-for-it.sh
CMD ["/home/wait-for-it.sh", "database:${PORT}" ,"--", "/entrypoint.py"]