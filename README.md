# Omero Docker

This repo contains the scripts needed to run Omero on our production server as
well as our local laptops for development. It uses `docker-compose` to make
deployments a bit easier.

`docker-compose` supports automatic override files for local development. Make
a special `docker-compose.override.yml` file and it will automatically overlay
on the already existing `docker-compose.yml` file. Docs [here][1].

Using overrides allows us to separate the production and local development
configs without too much effort.

[1]: https://docs.docker.com/compose/extends/#understanding-multiple-compose-files
