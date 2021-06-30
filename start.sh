#!/usr/bin/env bash

source ./settings.sh

function remove_containers() {
  if [[ -n $DOCKER_PATH ]]; then
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

while getopts "msophd" OPTION; do
  case $OPTION in
  m)
    export DOCKER_PATH="/mysql/"
    export PORT=3306
    ;;
  s)
    export DOCKER_PATH="/mssql/"
    export PORT=1433
    ;;
  o)
    export DOCKER_PATH="/oracle/"
    export PORT=1521
    ;;
  p)
    export DOCKER_PATH="/postgres/"
    export PORT=1521
    ;;
  d)
    export COMMAND="-Xdebug -Xrunjdwp:transport=dt_socket,address=5005,server=y,suspend=n"
    ;;
  h)
    echo "Usage:"
    echo "start.sh -OPTION [-d] [-h]"
    echo "OPTION:"
    echo "   -m     to start mysql db"
    echo "   -s     to start mssql db"
    echo "   -p     to start postgres db"
    echo "   -o     to start oracle db"
    echo "-h     help"
    echo "-d     run into debug mode"
    exit 0
    ;;
  *)
    exit 0
    ;;
  esac
done

function main() {
  export CURRENT_PATH="${CURRENT_PATH}${DOCKER_PATH}"
  cd "$CURRENT_PATH" || exit
  docker-compose -f ../jira-docker.yml -f docker-compose.yml config >docker-temp.yml
  docker-compose -f docker-temp.yml up --build
}

main
