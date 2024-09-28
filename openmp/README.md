# openmp
The Docker image `openmp` relies on Alpine 3.13.7 and contains GCC 10 which provides support for OpenMP 4.5 and also initial support for OpenMP 5.
It allows you to build and run your OpenMP programs in a docker container without the need to install GCC on your machine.

## Tools
The following tools are installed:
- gcc and g++
- Common developer tools (make, wget, curl, etc.)

## How to use
Run the following command:
```
$ docker run --rm -it -v $(pwd):/project mfisherman/openmp
```
It will automatically download the docker image to your system and run it.
The argument `-it` allows you to run the container in interactive mode and will open a shell.
Further, the command mounts the directory, from where you run the command above, into the folder `/project`of the container.
That way you can use your favorite editor to write your code an run `gcc` in the container.

## OS/ARCH
The image is built for a majority of Linux architectures, allowing you to run the image even on all Raspberry Pi versions (e.g. as gitlab-runner).
The available operating systems and architectures are:

 - linux/amd64
 - linux/386
 - linux/arm/v6
 - linux/arm/v7
 - linux/arm64
