#!/bin/sh

# Run this script in order to automate the generation of libprotobuf-lite.a for
# use on an embedded cortex m3 processor

# exit on any command that returns a non-zero status
set -e

# autogen has the wrong line endings for unix.  Fix them.
COMMAND="dos2unix autogen.sh"
eval $COMMAND

# Generate our autoconf script
COMMAND="./autogen.sh"
eval $COMMAND

# This sets up the repo and generates the makefiles and compile switches for our target
COMMAND="./configure --host=arm-none-eabi CPPFLAGS='-DGOOGLE_PROTOBUF_NO_THREAD_SAFETY' LDFLAGS='--specs=nosys.specs'"
eval $COMMAND

# Build our target lib
cd src
COMMAND="make -j8 libprotobuf-lite.la"
eval $COMMAND