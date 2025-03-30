# openmpi
The Docker image `openmpi` relies on Alpine 3.21.3 and contains Open MPI 5.0.7 (latest).
It allows you to build and run your MPI programs in a docker container without the need to install MPICH or Open MPI on your machine.

## Tools
The following tools are installed:
- Open MPI compiler (mpicc and mpicxx) and mpirun
- gcc and g++
- Common developer tools (make, wget, curl, etc.)

## How to use
Run the following command:
```
$ docker run --rm -it -v $(pwd):/project mfisherman/openmpi
```
It will automatically download the docker image to your system and run it.
The argument `-it` allows you to run the container in interactive mode and will open a shell.
Further, the command mounts the directory, from where you run the command above, into the folder `/project`of the container.
That way you can use your favorite editor to write your code an run `mpicc`and `mpiccxx`in the container.

## OS/ARCH
The image is built for a majority of Linux architectures, allowing you to run the image even on all Raspberry Pi versions (e.g. as gitlab-runner).
The available operating systems and architectures are (Open MPI 5.0.x does not support 32bit architectures, see https://github.com/open-mpi/ompi/issues/11248 - use MPI 4.x for 32bit architectures such as ARMv7/ARMv6/x86):

 - linux/amd64
 - linux/arm64

