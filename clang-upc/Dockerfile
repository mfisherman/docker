FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
      && apt-get upgrade -y \
      && apt-get install -y \
         clang \
         cmake \
         make \
         python3 \
         wget

ARG UPC_VERSION="3.9.1-2"
ARG UPC_MAKE_OPTIONS="-j4"
ARG UPC_CMAKE_OPTIONS="-DLLVM_TARGETS_TO_BUILD=host -DCMAKE_BUILD_TYPE=Release -DLLVM_BUILD_LLVM_DYLIB=on -DLLVM_LINK_LLVM_DYLIB=on"

#### Download, build, and install Clang UPC ####
RUN mkdir /tmp/upc-src
WORKDIR /tmp/upc-src
RUN wget https://github.com/clangupc/clang-upc/releases/download/clang-upc-${UPC_VERSION}/clang-upc-${UPC_VERSION}.tar.gz \
      && tar xfz clang-upc-${UPC_VERSION}.tar.gz
RUN mkdir build
RUN cd build && export CC=/usr/bin/clang && export CXX=/usr/bin/clang++ && cmake ${UPC_CMAKE_OPTIONS} ../clang-upc-${UPC_VERSION}
RUN cd build && make ${UPC_MAKE_OPTIONS}
RUN cd build && make install

#### Create a package using cpack ####
RUN cd build && cpack

#### Test the UPC installation ####
RUN mkdir /tmp/upc-test
WORKDIR /tmp/upc-test
COPY upc-test .
RUN sh test.sh
RUN rm -rf /tmp/upc-test



FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
      && apt-get upgrade -y \
      && apt-get install -y \
         cmake \
         make

#### Copy the installed files ####
COPY --from=0 /usr/local /usr/local

#### Test the UPC installation ####
RUN mkdir /tmp/upc-test
WORKDIR /tmp/upc-test
COPY upc-test .
RUN sh test.sh
RUN rm -rf /tmp/upc-test

#### Add a default user ####
ARG USER=upc
ENV USER ${USER}
RUN adduser ${USER}

ENV USER_HOME /home/${USER}
RUN chown -R ${USER}:${USER} ${USER_HOME}

#### Create a working directory for the user ####
ARG WORKDIR=/project
ENV WORKDIR ${WORKDIR}
RUN mkdir ${WORKDIR}
RUN chown -R ${USER}:${USER} ${WORKDIR}

WORKDIR ${WORKDIR}
USER ${USER}
