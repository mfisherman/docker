FROM debian:trixie-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG MIKTEX_VERSION="25.2"

RUN apt-get update
RUN    apt-get install -y --no-install-recommends \
           bison \
           ca-certificates \
	       cmake \
           curl \
           dpkg-dev \
           file \
           flex \
           g++ \
           gcc \
           gettext \
           gosu \
           libboost-all-dev \
           libbz2-dev \
           libcairo2-dev \
           libcurl4-openssl-dev \
           libfribidi-dev \
           libgd-dev \
           libgmp-dev \
           libgraphite2-dev \
           libhunspell-dev \
           libicu-dev \
           liblog4cxx-dev \
# libmpfi-dev version 1.5.4 is only available on testing for now. 
# See https://www.mail-archive.com/debian-bugs-dist@lists.debian.org/msg1962203.html
           libmpfi-dev \
           libmpfi-dev-common \
           libmpfr-dev \
           libmspack-dev \
           libpopt-dev \
           libpotrace-dev \
           libqt6qml6 \
           libssl-dev \
           liburiparser-dev \
           libzzip-dev \
           make \
           qt6-5compat-dev \
           qt6-base-dev \
           qt6-declarative-dev \
           qt6-tools-dev \
           xsltproc \
           xz-utils \
           wget

RUN mkdir /tmp/miktex-src
WORKDIR /tmp/miktex-src

RUN wget --no-check-certificate https://github.com/MiKTeX/miktex/archive/refs/tags/${MIKTEX_VERSION}.tar.gz \
      && tar -xf ${MIKTEX_VERSION}.tar.gz
RUN cd miktex-${MIKTEX_VERSION} && mkdir build && cd build && cmake -DUSE_SYSTEM_POPPLER=FALSE \
                                                                    -DUSE_SYSTEM_POPPLER_QT5=FALSE \
                                                                    -DUSE_SYSTEM_HARFBUZZ=FALSE \
                                                                    -DUSE_SYSTEM_HARFBUZZ_ICU=FALSE \
                                                                    ..
RUN cd miktex-${MIKTEX_VERSION}/build && make -j4
RUN cd miktex-${MIKTEX_VERSION}/build && make package


FROM debian:trixie-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG MIKTEX_VERSION="25.2"
ARG PLATFORM="amd64"

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        ca-certificates \
        python3 \
        make \
        ghostscript \
        wget \
        perl \
        git

COPY --from=0 /tmp/miktex-src/miktex-${MIKTEX_VERSION}/build/miktex_${MIKTEX_VERSION}-xenial1_${PLATFORM}.deb .
RUN apt-get install -y --no-install-recommends ./miktex_${MIKTEX_VERSION}-xenial1_${PLATFORM}.deb


RUN miktexsetup finish \
    && initexmf --admin --set-config-value=[MPM]AutoInstall=1 \
    && mpm --admin --update-db \
    && mpm --update-db \
    && mpm --admin \
           --install amsfonts \
           --install biber-linux-x86_64 \
    && initexmf --admin --update-fndb \
    && mpm --admin --update \
    && mpm --update

#### TEST MIKTEX INSTALLATION ####
RUN mkdir /tmp/texlive-test
WORKDIR /tmp/texlive-test
COPY latex-test .
RUN pdflatex test.tex

#### CLEAN UP ####
WORKDIR /
RUN rm -rf /tmp/*

WORKDIR /data

