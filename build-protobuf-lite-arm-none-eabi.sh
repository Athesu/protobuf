#!/bin/sh

# Run this script in order to automate the generation of libprotobuf-lite.a for
# use on an embedded cortex m3 processor

# exit on any command that returns a non-zero status
set -e

# Help for a couple common problems
echo "You must run this script from a Cygwin command prompt (not the 'terminal' in SourceTree).

Aside from the default packages within Cygwin, make sure you install these as well:
autoconf (wrapper)
automake (wrapper)
libtool
gcc-g++
make

If you get errors about a missing msvc file in the gtest directory, recursively reset hard the protobuf repo.


"

# autogen has the wrong line endings for unix.  Fix them.
eval "dos2unix autogen.sh"

# Generate our autoconf script
eval "./autogen.sh"

# This sets up the repo and generates the makefiles and compile switches for our target
eval "./configure --disable-shared --host=arm-none-eabi CPPFLAGS='-std=c++11 -mthumb -mlittle-endian -ggdb -mcpu=cortex-m3 -DGOOGLE_PROTOBUF_NO_RTTI -DGOOGLE_PROTOBUF_NO_STATIC_INITIALIZER -DGOOGLE_PROTOBUF_NO_THREAD_SAFETY' LDFLAGS='-mthumb -mcpu=cortex-m3 --specs=nosys.specs'"

# Build our target lib
cd src
eval "make -j8 libprotobuf-lite.la"
