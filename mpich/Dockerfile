FROM debian:bullseye-slim

ARG TARGETPLATFORM

RUN apt-get update && apt-get upgrade -y
RUN if [ "$TARGETPLATFORM" = "linux/arm/v6" ]; then \
      apt-get install -y wget gcc g++ gfortran make git python3; \
    else \
      apt-get install -y wget gcc g++ gfortran make valgrind git python3; \
    fi

#### INSTALL MPICH ####
# Source is available at http://www.mpich.org/static/downloads/

# Build Options:
# See installation guide of target MPICH version
# Ex: http://www.mpich.org/static/downloads/3.4/mpich-3.4-installguide.pdf
# These options are passed to the steps below
ARG MPICH_VERSION="4.0.3"
ARG MPICH_CONFIGURE_OPTIONS="FFLAGS=-fallow-argument-mismatch FCFLAGS=-fallow-argument-mismatch --with-device=ch4:ofi"
ARG MPICH_MAKE_OPTIONS="-j4"

# Download, build, and install MPICH
RUN mkdir /tmp/mpich-src
WORKDIR /tmp/mpich-src
RUN wget http://www.mpich.org/static/downloads/${MPICH_VERSION}/mpich-${MPICH_VERSION}.tar.gz \
      && tar xfz mpich-${MPICH_VERSION}.tar.gz
RUN cd mpich-${MPICH_VERSION} && ./configure ${MPICH_CONFIGURE_OPTIONS}
RUN cd mpich-${MPICH_VERSION} && make ${MPICH_MAKE_OPTIONS}
RUN cd mpich-${MPICH_VERSION} && make install
RUN rm -rf /tmp/mpich-src

#### EXPLICITLY EXPORT LIBFABRIC (OTHERWISE IT WON'T FIND LIBFABRIC) ####
ENV LD_LIBRARY_PATH="/usr/local/lib/:${LD_LIBRARY_PATH}"

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
RUN adduser --disabled-password ${USER}

ENV USER_HOME /home/${USER}
RUN chown -R ${USER}:${USER} ${USER_HOME}

#### CREATE WORKING DIRECTORY FOR USER ####
ARG WORKDIR=/project
ENV WORKDIR ${WORKDIR}
RUN mkdir ${WORKDIR}
RUN chown -R ${USER}:${USER} ${WORKDIR}

WORKDIR ${WORKDIR}
USER ${USER}
