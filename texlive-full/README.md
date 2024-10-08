# texlive-full
The Docker image `texlive-full` relies on Alpine 3.19.1 and contains a texlive-full installation.
It allows you to build your LaTex sources in a docker container without the need to install texlive on your machine.
Compared to other images, this texlive installation is up to date (2024) and also contains common build tools (biber, make, python, git).


## Tools
The following tools are installed:
- texlive-full 2024 (pdflatex, latex, bibtex, dvips, ps2pdf14 etc.)
- biber, make, python, git

## How to use
Run the following command:
```
$ docker run --rm -it -v $(pwd):/data mfisherman/texlive-full /bin/sh
```
It will automatically download the docker image to your system and run it.
The argument `-it` allows you to run the container in interactive mode and will open a shell.
Further, the command mounts the directory, from where you run the command above, into the folder `/data`of the container.
That way you can use your favorite editor to write your LaTex and compile it in the container.

## OS/ARCH
The image is built for a majority of Linux architectures, allowing you to run the image even on all Raspberry Pi versions (e.g. as gitlab-runner).
The available operating systems and architectures are:

 - linux/amd64
 - linux/arm/v6
 - linux/arm/v7
 - linux/arm64

