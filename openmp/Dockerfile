FROM alpine:3.13.7

RUN apk update \
      && apk upgrade \
      && apk add --no-cache \
         build-base \
         git \
         gcc \
         make \
         wget

#### TEST OpenMP INSTALLATION ####
RUN mkdir /tmp/openmp-test
WORKDIR /tmp/openmp-test
COPY openmp-test .
RUN sh test.sh
RUN rm -rf /tmp/openmp-test

#### ADD DEFAULT USER ####
ARG USER=openmp
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
