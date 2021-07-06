ARG JIRA_VERSION
FROM atlassian/jira-software:$JIRA_VERSION
ARG PORT

ENV DATABASE_PORT=${PORT}

COPY ./drivers/mysql-connector-java-8.0.25.jar /opt/atlassian/jira/lib/
COPY ./drivers/ojdbc7.jar /opt/atlassian/jira/lib/
COPY ./drivers/ojdbc8.jar /opt/atlassian/jira/lib/
COPY ./scripts/wait-for-it.sh /home
COPY ./scripts/entrypoint.sh /home

RUN chmod +x /home/wait-for-it.sh
RUN chmod +x /home/entrypoint.sh
RUN echo ${DATABASE_PORT}
CMD ["/home/entrypoint.sh"]