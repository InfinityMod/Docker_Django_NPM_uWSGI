#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"


. "$DIR/scripts/_init.sh"

if testcmd konsole; then
    exec konsole --noclose -e  "bash \"$DIR/scripts/docker_exec.sh\" \"/bin/bash /home/docker/code/dev.sh\""
else
    bash $DIR/scripts/docker_exec.sh "/bin/bash /home/docker/code/dev.sh"
fi
