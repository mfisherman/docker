FROM ubuntu:25.04

# See the installation instructions on
# https://github.com/uxlfoundation/oneTBB/blob/master/INSTALL.md

ARG SOURCE_DIR="/oneTBB"
ARG BUILD_DIR="/oneTBB/build"
ARG INSTALL_DIR="/opt/onetbb"
ARG TAG="v2022.1.0"

# Install build dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    cmake \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download the sources and unpack
RUN mkdir -p ${SOURCE_DIR} && \
      wget -O oneTBB.tar.gz https://github.com/uxlfoundation/oneTBB/archive/refs/tags/${TAG}.tar.gz && \
      tar -xf oneTBB.tar.gz -C ${SOURCE_DIR} --strip-components 1 && \
      rm oneTBB.tar.gz


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
FROM ubuntu:25.04

ARG INSTALL_DIR="/opt/onetbb"

# Install packages
RUN apt-get update && apt-get install -y \
      gcc \
      g++ \
      cmake \
      git \
      && rm -rf /var/lib/apt/lists/*

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
