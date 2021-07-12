#!/usr/bin/env bash

source ./scripts/settings.sh

function remove_containers() {
  if [[ -n $CURRENT_PATH ]]; then
    docker-compose -f docker-temp.yml down --remove-orphans --volumes
    rm docker-temp.yml
  fi
}

trap remove_containers INT

if [ $# -eq 0 ]; then
  echo "Missing options!"
  echo "(run $0 -h for help)"
  echo ""
  exit 0
fi

while getopts "msophdv::" OPTION; do
  case $OPTION in
  h)
    echo "Usage:"
    echo "start.sh -OPTION [-d] [-v] [-h]"
    echo "OPTION:"
    echo "   -m     to start mysql db"
    echo "   -s     to start mssql db"
    echo "   -p     to start postgres db"
    echo "   -o     to start oracle db"
    echo "-v     specify jira version. Default: 8.14"
    echo "-h     help"
    echo "-d     run into debug mode"
    exit 0
    ;;
  m)
    DOCKER_PATH="/mysql/"
    PORT=3306
    ;;
  s)
    DOCKER_PATH="/mssql/"
    PORT=1433
    ;;
  o)
    DOCKER_PATH="/oracle/"
    PORT=1521
    ;;
  p)
    DOCKER_PATH="/postgres/"
    PORT=5432
    ;;
  d)
    export COMMAND=$DEBUG_COMMAND
    ;;
  v)
    JIRA_VERSION=${OPTARG}
    ;;
  *)
    exit 0
    ;;
  esac
done

function main() {
  export CURRENT_PATH="${CURRENT_PATH}${DOCKER_PATH}"
  cd "$CURRENT_PATH" || exit
  export PORT=$PORT
  export JIRA_VERSION=${JIRA_VERSION}
  docker-compose -f ../jira-docker.yml -f docker-compose.yml config >docker-temp.yml
  docker-compose -f docker-temp.yml up --build
}

main
