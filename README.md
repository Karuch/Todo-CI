**portofolio-app**

**Description**
Full CICD pipeline for "todo" application.
Todo application allow us to add / edit / delete / get items from list (Json format)
we can use the web UI (html & css) and the backend written in python, webserver using FLASK.
DB using mongodb.
The applcation includes an API which we can use to quary our "todo list"
as the name suggests, it suppose to be used for manage "todo tasks" from our daily lives!

* Note that when you deploying the application using docker compose it tests all the API methods, using the "test application" which is image contains a bash script to check this.
If one of the methods fails to work, it terminates the process.

* Images (3): tal/todo, tal/mongodb, tal/test.

* the repo contains also configured Jenkinsfile and the things it needs for CI.

It checks that todo app image works correctly then upload it to the desired image registry.
The check-tag.sh used for the CI.

**Installation**

git clone git@gitlab.com:tal_docs/portfolio-docker.git

docker compose up

if you don’t have docker see: https://docs.docker.com/

**Usage**
Todo application & API: https://gitlab.com/tal_docs/portfolio-docker/-/blob/main/src/README.md

**Support**
talk474747@gmail.com

**Contributing**
I’m currently not open for contributing to the project.
Authors and acknowledgment
Todo app written by michel from develeap.

**Project status**
Done.