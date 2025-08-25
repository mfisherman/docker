FROM ubuntu:22.04

# See the installation instructions on
# https://github.com/uxlfoundation/oneTBB/blob/master/INSTALL.md

ARG SOURCE_DIR="/oneTBB"
ARG BUILD_DIR="/oneTBB/build"
ARG INSTALL_DIR="/opt/onetbb"
ARG TAG="v2021.3.0"

# Install build dependencies
RUN apt-get update && apt-get install -y \
    gcc-9 \
    g++-9 \
    cmake \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set gcc-9 and g++-9 as default
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100

# Download the sources and unpack
RUN mkdir -p ${SOURCE_DIR} && \
      wget -O oneTBB.tar.gz https://github.com/uxlfoundation/oneTBB/archive/refs/tags/${TAG}.tar.gz && \
      tar -xf oneTBB.tar.gz -C ${SOURCE_DIR} --strip-components 1 && \
      rm oneTBB.tar.gz

# Fix for:
# /oneTBB/src/tbbmalloc/frontend.cpp:829:49: error: 'getSmallObjectIndex' was not declared in this scope
RUN sed -i 's/#if __TBB_x86_32 || __aarch32__/#if __TBB_x86_32 || __aarch32__ || __arm__/' ${SOURCE_DIR}/src/tbbmalloc/frontend.cpp

# Configure CMake
RUN mkdir -p ${BUILD_DIR}
WORKDIR ${BUILD_DIR}
RUN cmake -DCMAKE_BUILD_TYPE=Release \
          -DTBB_TEST=OFF \
          -DBUILD_SHARED_LIBS=ON \
          -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} ..

# Build oneTBB and install
RUN cmake --build . && \
      cmake --install . && \
      rm -rf ${BUILD_DIR}


# Stage 2: Runtime image
FROM ubuntu:22.04

ARG INSTALL_DIR="/opt/onetbb"

# Install packages
RUN apt-get update && apt-get install -y \
      gcc-9 \
      g++-9 \
      cmake \
      git \
      && rm -rf /var/lib/apt/lists/*

# Set gcc-9 and g++-9 as default
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100

# Copy only installed TBB files
COPY --from=0 ${INSTALL_DIR} ${INSTALL_DIR}

# Set environment variables
ENV PATH="${INSTALL_DIR}/bin:${PATH}"
ENV LD_LIBRARY_PATH="${INSTALL_DIR}/lib:${LD_LIBRARY_PATH}"
ENV CPLUS_INCLUDE_PATH="${INSTALL_DIR}/include"
ENV LIBRARY_PATH="${INSTALL_DIR}/lib"

# Test oenTBB installation
RUN mkdir /tmp/onetbb-test
WORKDIR /tmp/onetbb-test
COPY onetbb-test .
RUN sh test.sh && rm -rf /tmp/*

WORKDIR /

# Add default user
ARG USER=onetbb
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
