# texlive
The Docker image texlive relies on Ubuntu 22.04 and contains a texlive installation from the texlive sources.
It allows you to build your LaTex sources in a docker container without the need to install texlive on your machine.
This image is inspired by [headgeekette](https://hub.docker.com/r/headgeekette/rpi-latex/), but is up to date (2024), contains common build tools (biber, make, python, git, texliveonfly) and is smaller than other images since not all packages are installed.
Note: biber is NOT included in the ARM builds, since they are not available by the native installation.


## Tools
The following tools are installed:
- texlive 2024 (pdflatex, latex, bibtex, dvips, ps2pdf14 etc.)
- make, python, git
- biber is only available in the linux/amd64 image

## How to use
Run the following command:
```
$ docker run --rm -it -v $(pwd):/data mfisherman/texlive /bin/sh
```
It will automatically download the docker image to your system and run it.
The argument `-it` allows you to run the container in interactive mode and will open a shell.
Further, the command mounts the directory, from where you run the command above, into the folder `/data`of the container.
That way you can use your favorite editor to write your LaTex and compile it in the container. Further packages can be installed using `tlmgr`.

## OS/ARCH
The image is built for a majority of Linux architectures, allowing you to run the image even on all Rasperry Pi versions (e.g. as gitlab-runner).
The available operating systems and architectures are:

 - linux/amd64
 - linux/arm/v7
 - linux/arm64

