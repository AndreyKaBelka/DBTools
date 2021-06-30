#!/usr/bin/zsh

set -a

DOCKER_PATH=""
COMMAND=""
JIRA_VERSION=8.14
CURRENT_PATH=$PWD

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
    DOCKER_PATH="/mysql/"
    ;;
  s)
    DOCKER_PATH="/mssql/"
    ;;
  o)
    DOCKER_PATH="/oracle/"
    ;;
  p)
    DOCKER_PATH="/postgres/"
    ;;
  d)
    COMMAND="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"
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
  CURRENT_PATH="${CURRENT_PATH}${DOCKER_PATH}"
  cd "$CURRENT_PATH" || exit
  docker-compose -f ../jira-docker.yml -f docker-compose.yml config > docker-temp.yml
  docker-compose -f docker-temp.yml up
}

main
