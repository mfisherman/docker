# mpich
The Docker image `mpich` relies on Debian Bullseye (Slim) and contains MPICH 4.1.
It allows you to build and run your MPI programs in a docker container without the need to install MPICH or OpenMPI on your machine.
The Dockerfile is inspired by [nlknguyen](https://hub.docker.com/r/nlknguyen/alpine-mpich/), but brings a more up to date base image and is built for a wide range of architectures.

## Tools
The following tools are installed:
- MPICH compiler (mpicc and mpicxx) and mpirun
- gcc and g++
- Common developer tools (make, wget, valgrind etc.)

## How to use
Run the following command:
```
$ docker run --rm -it -v $(pwd):/project mfisherman/mpich
```
It will automatically download the docker image to your system and run it.
The argument `-it` allows you to run the container in interactive mode and will open a shell.
Further, the command mounts the directory, from where you run the command above, into the folder `/project`of the container.
That way you can use your favorite editor to write your code an run `mpicc`and `mpiccxx`in the container.

## OS/ARCH
The image is built for a majority of Linux architectures, allowing you to run the image even on all Rasperry Pi versions (e.g. as gitlab-runner).
Note that valgrind is not available in linux/arm/v6.
The available operating systems and architectures are:

 - linux/amd64
 - linux/arm/v7
 - linux/arm/v6
 - linux/arm64
 - linux/386
