FROM ubuntu:impish-20220128 AS build

# Set current user as root to install things.
USER root

# Dependencies for building the protobuf.
RUN apt-get update && apt-get install -y --no-install-recommends \
       build-essential=12.9ubuntu2 \
       curl=7.74.0-1.3ubuntu2 \
       g++-multilib=4:11.2.0-1ubuntu1 \
       lib32z1-dev=1:1.2.11.dfsg-2ubuntu7 \
       autoconf=2.69-14 \
       automake=1:1.16.4-2 \
       libtool=2.4.6-15 \
       make=4.3-4ubuntu1 \
       unzip=6.0-26ubuntu1 \
       dos2unix=7.4.1-1 \
       gcc=4:11.2.0-1ubuntu1 \
       g++=4:11.2.0-1ubuntu1 \
       gcc-arm-none-eabi=15:9-2019-q4-0ubuntu2 \
       libc6-dev=2.34-0ubuntu3.2 \
       binutils-arm-none-eabi=2.36.1-0ubuntu1+14build1 \
       libnewlib-dev=3.3.0-1 \
       libstdc++-arm-none-eabi-newlib=15:9-2019-q4-0ubuntu1+13 \
       libnewlib-arm-none-eabi=3.3.0-1 \
       && apt-get autoremove -y

# Copy everything into the container.
COPY . /home/protobuf/

# Change the current directory to root of protobuf.
WORKDIR /home/protobuf/

# Convert autogen.sh and Makefile.am to Unix line endings
RUN dos2unix autogen.sh Makefile.am

# Generate the autogen file and configure.
RUN ./autogen.sh

# Configure the file
RUN ./configure --disable-shared --host=arm-none-eabi CPPFLAGS='-std=c++11 -mthumb -mlittle-endian -ggdb -mcpu=cortex-m3 -DGOOGLE_PROTOBUF_NO_RTTI -DGOOGLE_PROTOBUF_NO_STATIC_INITIALIZER -DGOOGLE_PROTOBUF_NO_THREAD_SAFETY' LDFLAGS='-mthumb -mcpu=cortex-m3 --specs=nosys.specs'

# Change the current directory to src.
WORKDIR src

# Build:
RUN make -j8 libprotobuf.la
