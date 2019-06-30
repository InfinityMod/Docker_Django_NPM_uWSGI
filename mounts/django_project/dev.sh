cd "$(dirname "$0")"
for i in ./**/_init.sh; do
    fname="${i%.*}"
    echo "Load $fname"
    sh -c "$i"
done
supervisorctl restart python-django
tail -qF "/tmp/supervisorctl_dev_django.log"
