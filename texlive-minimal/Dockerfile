FROM alpine:3.19.1

RUN apk update
RUN apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community add texlive=20240210.69778-r3
RUN apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community add python3 make ghostscript git biber

#### TEST TEXLIVE INSTALLATION ####
RUN mkdir /tmp/texlive-test
WORKDIR /tmp/texlive-test
COPY latex-test .
RUN pdflatex test.tex

#### CLEAN UP ####
WORKDIR /
RUN rm -rf /tmp/*

WORKDIR /data
