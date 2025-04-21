FROM ubuntu:24.04

ENV PATH=/usr/local/texlive/bin/x86_64-linuxmusl:$PATH
ENV PATH=/usr/local/texlive/bin/x86_64-linux:$PATH
ENV PATH=/usr/local/texlive/bin/armhf-linuxmusl:$PATH
ENV PATH=/usr/local/texlive/bin/armhf-linux:$PATH
ENV PATH=/usr/local/texlive/bin/aarch64-linuxmusl:$PATH
ENV PATH=/usr/local/texlive/bin/aarch64-linux:$PATH

COPY texlive-profile.txt /tmp/

RUN apt-get update
RUN apt-get install -y python3 make ghostscript wget perl git

RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    mkdir /tmp/install-tl && \
    tar -xzf install-tl-unx.tar.gz -C /tmp/install-tl --strip-components=1

RUN /tmp/install-tl/install-tl --profile=/tmp/texlive-profile.txt
RUN tlmgr update --self


RUN tlmgr install \
      collection-basic \
      collection-fontsrecommended \
      collection-latex \
      collection-latexrecommended \
      collection-latexextra \
      collection-mathscience \
      baskervaldadf \
      baskervaldx \
      biber \
      biblatex \
      cochineal \
      crimson \
      ebgaramond \
      ebgaramond-maths \
      fbb \
      fontawesome \
      ulem \
      texliveonfly
RUN rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/* \
      install-tl-unx.tar.gz

#### TEST TEXLIVE INSTALLATION ####
RUN mkdir /tmp/texlive-test
WORKDIR /tmp/texlive-test
COPY latex-test .
RUN pdflatex test.tex

#### CLEAN UP ####
WORKDIR /
RUN rm -rf /tmp/*

WORKDIR /data
