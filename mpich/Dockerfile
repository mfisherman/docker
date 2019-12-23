FROM alpine:3.10.3

RUN apk update \
      && apk upgrade \
      && apk add --no-cache build-base libatomic gfortran git valgrind

#### INSTALL MPICH ####
# Source is available at http://www.mpich.org/static/downloads/

# Build Options:
# See installation guide of target MPICH version
# Ex: http://www.mpich.org/static/downloads/3.3.2/mpich-3.3.2-installguide.pdf
# These options are passed to the steps below
ARG MPICH_VERSION="3.2.1"
ARG MPICH_CONFIGURE_OPTIONS
ARG MPICH_MAKE_OPTIONS="-j1"

# Download, build, and install MPICH
RUN mkdir /tmp/mpich-src
WORKDIR /tmp/mpich-src
RUN wget http://www.mpich.org/static/downloads/${MPICH_VERSION}/mpich-${MPICH_VERSION}.tar.gz \
      && tar xfz mpich-${MPICH_VERSION}.tar.gz
RUN cd mpich-${MPICH_VERSION} && ./configure ${MPICH_CONFIGURE_OPTIONS}
RUN cd mpich-${MPICH_VERSION} && make ${MPICH_MAKE_OPTIONS}
RUN cd mpich-${MPICH_VERSION} && make install
RUN rm -rf /tmp/mpich-src

#### TEST MPICH INSTALLATION ####
RUN mkdir /tmp/mpi-test
WORKDIR /tmp/mpi-test
COPY mpi-test .
RUN sh test.sh
RUN rm -rf /tmp/mpi-test

#### CLEAN UP ####
WORKDIR /
RUN rm -rf /tmp/*

#### ADD DEFAULT USER ####
ARG USER=mpi
ENV USER ${USER}
RUN adduser -D ${USER}

ENV USER_HOME /home/${USER}
RUN chown -R ${USER}:${USER} ${USER_HOME}

#### CREATE WORKING DIRECTORY FOR USER ####
ARG WORKDIR=/project
ENV WORKDIR ${WORKDIR}
RUN mkdir ${WORKDIR}
RUN chown -R ${USER}:${USER} ${WORKDIR}

WORKDIR ${WORKDIR}
USER ${USER}
