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

template_folder="$DIR/_template"
dst_folder="$DIR"

conf_static_appendix=""
_conf_statics_develop=""

#find statics
find_statics () {
    c_dir="$PWD"
    cd $DIR
    _conf_statics_develop="$(echo "$(find "../app/" -type d -name "static")" | 
    grep -v -f <(sed 's/\([.|]\)/\\\1/g; s/\?/./g ; s/\*/.*/g' "$template_folder/_static_dev.ignore") | 
    while IFS= read -r folder; do
        printf " ${folder:2}$conf_statics_appendix"
    done)"
    cd $c_dir
}
    
# Generate configs
cd $template_folder
for i in ./*.conf; do
    fname="${i%.*}"
    echo "Load $fname"
    source "$fname.settings"
    find_statics
    source "$fname.settings"
    ep -d "${template_folder}/${fname}.conf" > ${dst_folder}/${fname}.conf
done

cd $dst_folder

# Remove old symlinks
find /etc/nginx/sites-enabled/*.conf -type l -delete;

# Link configurations to nginx
cp -rs $dst_folder/*.conf /etc/nginx/sites-enabled/

