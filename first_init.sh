#!/bin/bash
#[ "$UID" -eq 0 ] || exec kdesu bash "$0" "$@"
PS4='$LINENO: '

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done

DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
IMG="django_2.2.1"

echo "Pull submodules"
git submodule update --init --recursive

echo "Extract image"
cat $(find "$DIR/images/" -name "$IMG.tar.gz*") > "$DIR/images/$IMG.tar.gz" 
gzip -d "$DIR/images/$IMG.tar.gz"

echo "Set links"
rm -rf "$DIR/.docker_toolbox/mounts"
rm -rf "$DIR/.docker_toolbox/images"
ln -s  "$DIR/.docker_toolbox/" "$DIR"
ln -s  "$DIR/mounts" "$DIR/.docker_toolbox/mounts"
ln -s  "$DIR/images" "$DIR/.docker_toolbox/images"

echo "Load image"
"$DIR/scripts/docker_load_image.sh" "$DIR/images/$IMG.tar"
rm "$DIR/images/$IMG.tar" 
echo "Finished!"

while true
do
    echo "Press [CTRL+C] to stop.."
    sleep 1
done

