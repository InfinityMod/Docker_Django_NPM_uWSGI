# Docker_Django_NPM_uWSGI
A django, npm and uWSGI supported docker setup for quickly deploying a minimal server environment on multiple systems.
The project is based on:
https://github.com/dockerfiles/django-uwsgi-nginx


## First steps<br>
Clone this repository with submodules:<br>
`git clone --recursive https://github.com/InfinityMod/Docker_Django_NPM_uWSGI`

Navigate to the repo:<br>
`cd <repo_path>`

Run first init:<br>
`./first_init.sh`

Start container:<br>
`./run_server.sh`

Start django development runtime in container (optional):<br>
`./run_django_dev.sh`

Navigate in your browser to production view:<br>
`http://127.0.0.1:8020`

Navigate in your browser to development view:<br>
`http://localhost:8021`
