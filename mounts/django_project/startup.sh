#!/bin/bash
PS4='$LINENO: '

#Get Script dir
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

cd "$(dirname "$0")"
for i in ./**/_init.sh; do
    fname="${i%.*}"
    echo "Load $fname"
    sh -c "$i"
done
supervisord &&
sleep 5 &&
supervisorctl restart app-uwsgi
sleep 1 &&
supervisorctl restart nginx-app
while true
do
    echo "Press [CTRL+C] to stop.."
    sleep 1
done

