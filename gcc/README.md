# gcc
The Docker image `gcc` relies on Ubuntu 20.04 and contains a set of often used build tools for C/C++ projects.

## Tools
The following tools are installed:
- gcc and g++
- make, cmake, valgrind
- libpcap-dev, libjsoncpp-dev, liblog4cpp5-dev

## How to use
Run the following command:
```
$ docker run --rm -it -v $(pwd):/project mfisherman/gcc
```
It will automatically download the docker image to your system and run it.
The argument `-it` allows you to run the container in interactive mode and will open a shell.
Further, the command mounts the directory, from where you run the command above, into the folder `/project`of the container.
That way you can use your favorite editor to write your code an run `gcc`and `g++`in the container.

## OS/ARCH
The image is built for a majority of Linux architectures, allowing you to run the image even on all Rasperry Pi versions (e.g. as gitlab-runner).
The available operating systems and architectures are:

 - linux/amd64
 - linux/arm/v7
 - linux/arm64
 - linux/386
