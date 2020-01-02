FROM ubuntu:19.04

#### COMMON BUILD TOOLS ####
RUN apt-get update \
      && apt-get upgrade \
      && apt-get install -y gcc valgrind make cmake g++ build-essential

#### COMMON LIBRARIES ####
RUN apt-get install -y liblog4cpp5-dev libpcap-dev libjsoncpp-dev

#### TEST GCC INSTALLATION ####
RUN mkdir /tmp/gcc-test
WORKDIR /tmp/gcc-test
COPY gcc-test .
RUN sh test.sh
RUN rm -rf /tmp/gcc-test

#### CLEAN UP ####
WORKDIR /
RUN rm -rf /tmp/*

#### ADD DEFAULT USER ####
ARG USER=gccuser
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
