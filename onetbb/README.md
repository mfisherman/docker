# onetbb
The Docker image `onetbb` relies on Ubuntu 25.04 and contains oneAPI Threading Building Blocks (oneTBB) 2021.7.0.
It allows you to build and run your oneTBB programs in a docker container without the need to install oneTBB on your machine.

## Tools
The following tools are installed:
- gcc/g++ with oneTBB (supports the `-ltbb` flag)
- Common developer tools (git, cmake)

## How to use
Run the following command:
```
$ docker run --rm -it -v $(pwd):/project mfisherman/onetbb
```
It will automatically download the docker image to your system and run it.
The argument `-it` allows you to run the container in interactive mode and will open a shell.
Further, the command mounts the directory, from where you run the command above, into the folder `/project`of the container.
That way you can use your favorite editor to write your code and run gcc/g++ to compile your oneTBB programs.

## OS/ARCH
The available operating systems and architectures are:

- linux/amd64
- linux/arm64
- linux/arm/v7
