#!/usr/bin/zsh

DOCKER_PATH=""

function remove_containers() {
  if [[ -n $DOCKER_PATH ]]; then
    docker-compose -f docker-compose.yml down --remove-orphans --volumes
  fi
}

trap remove_containers INT

if [ $# -eq 0 ]; then
  echo "Missing options!"
  echo "(run $0 -h for help)"
  echo ""
  exit 0
fi

while getopts "msoph" OPTION; do
  case $OPTION in
  m)
    DOCKER_PATH="./mysql"
    ;;
  s)
    DOCKER_PATH="./mssql"
    ;;
  o)
    DOCKER_PATH="./oracle"
    ;;
  p)
    DOCKER_PATH="./postgres"
    ;;
  h)
    echo "Usage:"
    echo "start.sh [-OPTION]"
    echo "OPTION:"
    echo "   -m     to start mysql db"
    echo "   -s     to start mssql db"
    echo "   -p     to start postgres db"
    echo "   -o     to start oracle db"
    echo "   -h     help"
    exit 0
    ;;
  *)
    exit 0
    ;;
  esac
done

function main() {
  cd $DOCKER_PATH || exit
  docker-compose -f docker-compose.yml up
}

main
