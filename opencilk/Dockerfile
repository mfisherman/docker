FROM ubuntu:24.04

# This Dockerfile is similar to the release tools and Dockerfile in 
# https://github.com/OpenCilk/infrastructure/tree/release

ARG TAG="opencilk/v1.0"
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
# /opencilk/opencilk-project/compiler-rt/lib/dfsan/dfsan_custom.cpp:909:9: note: 'free' is defined in header '<cstdlib>'; did you forget to '#include <cstdlib>'?
RUN sed -i '42a #include <cstdlib>' /opencilk/opencilk-project/compiler-rt/lib/dfsan/dfsan_custom.cpp
RUN sed -i '43a extern "C" void* calloc(size_t, size_t);' /opencilk/opencilk-project/compiler-rt/lib/dfsan/dfsan_custom.cpp
RUN sed -i '44a extern "C" void* malloc(size_t);' /opencilk/opencilk-project/compiler-rt/lib/dfsan/dfsan_custom.cpp
RUN sed -i '45a extern "C" long int strtol(const char* nptr, char** endptr, int base);' /opencilk/opencilk-project/compiler-rt/lib/dfsan/dfsan_custom.cpp
RUN sed -i '46a extern "C" double strtod(const char* nptr, char** endptr);' /opencilk/opencilk-project/compiler-rt/lib/dfsan/dfsan_custom.cpp
RUN sed -i '47a extern "C" long long int strtoll(const char* nptr, char** endptr, int base);' /opencilk/opencilk-project/compiler-rt/lib/dfsan/dfsan_custom.cpp
RUN sed -i '48a extern "C" unsigned long int strtoul(const char* nptr, char** endptr, int base);' /opencilk/opencilk-project/compiler-rt/lib/dfsan/dfsan_custom.cpp
RUN sed -i '49a extern "C" long long unsigned int strtoull(const char* nptr, char** endptr, int base);' /opencilk/opencilk-project/compiler-rt/lib/dfsan/dfsan_custom.cpp
RUN sed -i '50a extern "C" void free(void* ptr);' /opencilk/opencilk-project/compiler-rt/lib/dfsan/dfsan_custom.cpp
# /opencilk/opencilk-project/llvm/utils/benchmark/src/benchmark_register.h:17:30: error: 'numeric_limits' is not a member of 'std'
RUN sed -i '4a #include <limits>' /opencilk/opencilk-project/llvm/utils/benchmark/src/benchmark_register.h
# /opencilk/opencilk-project/llvm/include/llvm/Support/Signals.h:117:24: error: 'uintptr_t' was not declared in this scope
RUN sed -i '17a #include <cstdint>' /opencilk/opencilk-project/llvm/include/llvm/Support/Signals.h
# /opencilk/opencilk-project/llvm/lib/Support/Unix/Signals.inc:348:44: error: 'void llvm::sys::CleanupOnSignal(uintptr_t)' should have been declared inside 'llvm::sys'
RUN sed -i 's/\bvoid sys::CleanupOnSignal(/void llvm::sys::CleanupOnSignal(/' /opencilk/opencilk-project/llvm/lib/Support/Unix/Signals.inc
RUN cat /opencilk/opencilk-project/llvm/lib/Support/Unix/Signals.inc

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
