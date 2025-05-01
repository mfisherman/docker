FROM ubuntu:24.04

# This Dockerfile is similar to the release tools and Dockerfile in 
# https://github.com/OpenCilk/infrastructure/tree/release

ARG TAG="opencilk/v1.1"
ARG OPENCILK_SOURCE="/opencilk/opencilk-project"
ARG CHEETAH_SOURCE="${OPENCILK_SOURCE}/cheetah"
ARG CILKTOOLS_SOURCE="${OPENCILK_SOURCE}/cilktools"
ARG BUILD_DIR="/opencilk/build"
ARG INSTALL_DIR="/opt/opencilk"
ARG FOO="foo"

# Install required packages for buiding
RUN apt-get update
RUN apt-get install -y \
      cmake \
      gcc \
      g++ \
      libc6-dev \
      python3 \
      wget \
      xz-utils

# Download the sources and unpack
# Generates ca. 2GB of data
RUN mkdir -p ${OPENCILK_SOURCE} && \
      wget -O opencilk-project.tar.gz https://github.com/OpenCilk/opencilk-project/archive/${TAG}.tar.gz && \
      tar -xf opencilk-project.tar.gz -C ${OPENCILK_SOURCE} --strip-components 1 && \
      rm opencilk-project.tar.gz
RUN mkdir -p ${CHEETAH_SOURCE} && \
      wget -O cheetah.tar.gz https://github.com/OpenCilk/cheetah/archive/${TAG}.tar.gz && \
      tar -xf cheetah.tar.gz -C ${CHEETAH_SOURCE} --strip-components 1 && \
      rm cheetah.tar.gz
RUN mkdir -p ${CILKTOOLS_SOURCE} && \
      wget -O cilktools.tar.gz https://github.com/OpenCilk/productivity-tools/archive/${TAG}.tar.gz && \
      tar -xf cilktools.tar.gz -C ${CILKTOOLS_SOURCE} --strip-components 1 && \
      rm cilktools.tar.gz

# Fix compilation errors
# /opencilk/opencilk-project/llvm/include/llvm/Support/Signals.h:119:24: error: 'uintptr_t' was not declared in this scope
RUN sed -i '17a #include <cstdint>' /opencilk/opencilk-project/llvm/include/llvm/Support/Signals.h

# Configure CMake
RUN mkdir -p ${BUILD_DIR}
WORKDIR ${BUILD_DIR}
RUN cmake -DLLVM_ENABLE_PROJECTS="clang;compiler-rt" \
      -DLLVM_ENABLE_RUNTIMES="cheetah;cilktools" \
      -DLLVM_ENABLE_ASSERTIONS=Off \
      -DLLVM_TARGETS_TO_BUILD=host \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
      -DLLVM_OPTIMIZED_TABLEGEN=On \
      ${OPENCILK_SOURCE}/llvm

# Build OpenCilk, install it into /opt/opencilk and remove the build folder
# Build generates ca. 4GB of data, install ca. 2.5GB
RUN cmake --build . -j 4 && \
      cmake --build . --target install && \
      rm -rf ${BUILD_DIR}


FROM ubuntu:24.04

ARG INSTALL_DIR="/opt/opencilk"

# Install packages, note that OpenCilk already comes with LLVM
RUN apt-get update && apt-get install -y \
      # dependencies
      libz3-4 \
      libc6-dev \
      # tools for development
      cmake \
      gcc \
      g++ \
      git \
      cmake

# Copy OpenCilk installation
COPY --from=0 ${INSTALL_DIR} ${INSTALL_DIR}

# Set environment variables
ENV PATH="${INSTALL_DIR}/bin:$PATH"
ENV LD_LIBRARY_PATH="${INSTALL_DIR}/lib:$LD_LIBRARY_PATH"

# Test Cilk installation
RUN mkdir /tmp/cilk-test
WORKDIR /tmp/cilk-test
COPY cilk-test .
RUN sh test.sh && rm -rf /tmp/*

WORKDIR /

# Add default user
ARG USER=cilk
ENV USER=${USER}
RUN adduser --disabled-password ${USER}

ENV USER_HOME=/home/${USER}
RUN chown -R ${USER}:${USER} ${USER_HOME}

# Create working directory for the user
ARG WORKDIR=/project
ENV WORKDIR=${WORKDIR}
RUN mkdir ${WORKDIR}
RUN chown -R ${USER}:${USER} ${WORKDIR}

WORKDIR ${WORKDIR}
USER ${USER}
