# clang-upc
The Docker image `clang-upc` relies on Ubuntu 20.04 and contains Clang Unified Parallel C (Clang UPC).
It allows you to build and run your UPC programs in a docker container without the need to install Clang UPC on your machine.

## Tools
The following tools are installed:
- Clang UPC Tool Set
- Common developer tools (make, wget, curl, etc.)

## How to use
Run the following command:
```
$ docker run --rm -it -v $(pwd):/project mfisherman/clang-upc
```
It will automatically download the docker image to your system and run it.
The argument `-it` allows you to run the container in interactive mode and will open a shell.
Further, the command mounts the directory, from where you run the command above, into the folder `/project`of the container.
That way you can use your favorite editor to write your code an run the compiler in the container.

## OS/ARCH
The available operating systems and architectures are:

 - linux/amd64
