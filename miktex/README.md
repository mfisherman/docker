# miktex
The Docker image miktex relies on Ubuntu 20.04 and contains a miktex installation.
It allows you to build your LaTex sources in a docker container without the need to install miktex on your machine.


## Tools
The following tools are installed:
- miktex (pdflatex, latex, bibtex, dvips, ps2pdf14 etc.)
- make, python, git

## How to use
Run the following command:
```
$ docker run --rm -it -v $(pwd):/data mfisherman/miktex /bin/sh
```
It will automatically download the docker image to your system and run it.
The argument `-it` allows you to run the container in interactive mode and will open a shell.
Further, the command mounts the directory, from where you run the command above, into the folder `/data`of the container.
That way you can use your favorite editor to write your LaTex and compile it in the container. Further packages can be installed using `tlmgr`.

## OS/ARCH
The image is built for a majority of Linux architectures, allowing you to run the image even on all Rasperry Pi versions (e.g. as gitlab-runner).
The available operating systems and architectures are:

 - linux/amd64
 - linux/arm/v6
 - linux/arm/v7
 - linux/arm64

