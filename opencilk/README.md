# opencilk
The Docker image `opencilk` relies on Ubuntu 24.04 and contains OpenCilk 2.0.1.
It allows you to build and run your Cilk programs in a docker container without the need to install OpenCilk or Cilk Plus on your machine.

## Tools
The following tools are installed:
- OpenCilk compiler (clang that supports the `-fopencilk` flag)
- Common developer tools (git, cmake)

## How to use
Run the following command:
```
$ docker run --rm -it -v $(pwd):/project mfisherman/opencilk
```
It will automatically download the docker image to your system and run it.
The argument `-it` allows you to run the container in interactive mode and will open a shell.
Further, the command mounts the directory, from where you run the command above, into the folder `/project`of the container.
That way you can use your favorite editor to write your code an run `clang` with the `-fopencilk` flag in the container.

## OS/ARCH
The image is built for 64bit architectures from source.
The available operating systems and architectures are:

- linux/amd64
- linux/arm64
