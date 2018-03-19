# docker-markdownd

A (smaller) Docker container for [markdownd](https://github.com/aerth/markdownd).

*markdownd* is an simple markdown server (no indexing, no symlinks) written in go-lang.


# Status

[![Docker Pulls](https://img.shields.io/docker/pulls/bodsch/docker-markdownd.svg?branch=1705-03)][hub]
[![Image Size](https://images.microbadger.com/badges/image/bodsch/docker-markdownd.svg?branch=1705-03)][microbadger]
[![Build Status](https://travis-ci.org/bodsch/docker-markdownd.svg?branch=1705-03)][travis]

[hub]: https://hub.docker.com/r/bodsch/docker-markdownd/
[microbadger]: https://microbadger.com/images/bodsch/docker-markdownd
[travis]: https://travis-ci.org/bodsch/docker-markdownd

# Theming

Example Files are located unter `themes`.
Stylesheets can be found under `styles`.


# Build

Your can use the included Makefile.

To build the Container: `make build`

To remove the builded Docker Image: `make clean`

Starts the Container: `make run`

Starts the Container with Login Shell: `make shell`

Entering the Container: `make exec`

Stop (but **not kill**): `make stop`

History `make history`


# Docker Hub

You can find the Container also at  [DockerHub](https://hub.docker.com/r/bodsch/docker-markdownd)

## get

    docker pull bodsch/docker-markdownd


# supported Environment Vars

# Ports

 - 8080
