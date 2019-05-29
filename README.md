# Docker_Django_NPM_uWSGI
A django, npm and uWSGI supported docker setup for quickly deploying a minimal server environment on multiple systems.

## First steps<br>
Clone this repository with submodules:<br>
`git clone --recursive https://github.com/InfinityMod/Docker_Django_NPM_uWSGI`

Navigate to the repo:<br>
`cd \<repo_path>`

Run first init:<br>
`.\first_init.sh`

Start container:<br>
`.\run_server.sh`

Start django in container:<br>
`.\run_django.sh`

Navigate in your browser to:<br>
`http://localhost:8000`
