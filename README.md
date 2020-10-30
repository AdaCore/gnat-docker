# Docker GNAT

The docker GNAT contains the Dockerfiles necessary to build a x86-64 Linux
[GNAT Pro](https://www.adacore.com/gnatpro)  docker image for use in CI or
general dockerized context.

The repository has the following directories:

- `gnatpro-deps/` Dockerfile for a basic image used to build the GNAT Pro toolsuite.
- `gnatpro/` Dockerfile for building a working compiler container, using a user-provided
GNAT pro release package.

In order to get a GNAT Pro release package, see [GNAT Pro versions](https://www.adacore.com/gnatpro/comparison).

## Requirements

* You must have a recent version of [Docker](https://docs.docker.com/get-started/#set-up-your-docker-environment).
* Scripts are developed and tested under a recent Linux distribution. Portability issues may arise
for building the images under Windows or MacOS.

For the GNAT Pro image:

* Put linux x86-64 GNAT Pro release in the `gnatpro/` directory
* Run the `doinstall` script (see below)

## Install

### Known issue

You will probably have access rights error, add yourself to the docker group with
`sudo usermod -aG docker $USER`
then restart your session (this may require a full OS restart).

or else run with sudo
`sudo doinstall`

### Steps

With `$gnat_release` as the GNAT Pro `.tar.gz` release filem and `$gnat_version` as the GNAT Pro
version number.
Run `./doinstall --gnat_version=$gnat_version $release_file`
NB: If you're unsure of the version number, let the argument empty for the script to infer it.

This will build two images
* `docker:deps` for package dependencies
* `docker:$gnat_version` for compilation, eg `docker:20.2`.

You can then use the `docker:$gnat_version` image to spawn new containers for compilation.

Warning: Due to some docker limitations, the release file will be copied to the `gnatpro/` dir. It
can safely be removed at the end of build.

## Quick check

Once you have created and tagged an image, you can check that GNAT is working properly
by running a compilation of the examples.

`docker run --entrypoint make -t gnat:$gnat_version -C /usr/gnat/share/examples/gnat RUN_DINERS=0`

It should compile and run all the GNAT examples, and finish on a successful error
code.

## Open a shell on the image

`docker run --entrypoint bash -it docker:$gnat_version` will give you access to a console shell
on the image.

You can then disconnect by either entering Ctrl+D or the `exit` command.
