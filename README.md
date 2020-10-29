# Docker GNAT

The docker GNAT contains the Dockerfiles necessary to build a x86-64 Linux
[GNATpro](https://www.adacore.com/gnatpro)  docker image for use in CI or
general dockerized context.

The repository contains the Dockerfiles necessary to build two images:
- gnatpro-deps is the basic image has the necessary elements to build the
GNATpro toolsuite.
- gnatpro is the image built from the gnatpro-deps image and using a user-provided
GNATpro release.

In order to get a GNATpro release, see [GNATpro versions](https://www.adacore.com/gnatpro/comparison).

## Requirements

* You must have a recent version of [Docker](https://docs.docker.com/get-started/#set-up-your-docker-environment).

For the GNATpro image:

* You must have a GNATpro release for linux 86-64
    - in the `gnatpro` directory
* The default expected name is `gnatpro-20.2-x86_64-linux-bin.tar.gz`
    - another release version and name can be specified using the `doinstall` script
    - ... or manually through the `gnat_release` [Docker build-time variable](https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables---build-arg)

## Install

Put the content of the GNATpro release as an archive in the `gnatpro/` directory.

Run `./doinstall --gnat-release=<release_file>`

### Known issue

Under Linux or BSD, if you have an access rights error, add yourself to the docker
group with `sudo group -aG docker $USER` then restart your session.

or else run with sudo
`sudo doinstall`

## Manual setup

Manual setup can be needed for advanced usages.

Run the build and specify the GNATpro archive file name:
`docker build --build-arg gnat_release=<release_archive_file> [-t <image_name>]`

## Quick check

Once you have created and tagged an image, you can check that GNAT is working properly
by running a compilation of the examples.

`docker run --entrypoint make -t <image name> -C /usr/gnat/share/examples/gnat RUN_DINERS=0`

It should compile and run all the JGNAT examples, and finish on a successful error
code.

## Open a shell on the image

`docker run --entrypoint bash -it <image_name>` will give you access to a console shell
on the image.

You can then disconnect by either entering Ctrl+D or the `exit` command.
