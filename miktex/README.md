# miktex
The Docker image miktex relies on Debian Bullseye (Slim) and contains a miktex installation.
It allows you to build your LaTex sources in a docker container without the need to install miktex on your machine.


## Tools
The following tools are installed:
- miktex 22.3 (pdflatex, latex, bibtex, dvips, ps2pdf14 etc.)
- make, python, git

## How to use
Run the following command:
```
$ docker run --rm -it -v $(pwd):/data mfisherman/miktex /bin/sh
```
It will automatically download the docker image to your system and run it.
The argument `-it` allows you to run the container in interactive mode and will open a shell.
Further, the command mounts the directory, from where you run the command above, into the folder `/data`of the container.
That way you can use your favorite editor to write your LaTex and compile it in the container.

## OS/ARCH
The image is built only for the Linux AMD64 architecture since MikeTex does not support other architectures such as ARM - see the according [issue on Github](https://github.com/MiKTeX/miktex/issues/240).
The available operating systems and architectures are:

 - linux/amd64

