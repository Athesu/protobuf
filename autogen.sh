#!/bin/sh

# Run this script to generate the configure script and other files that will
# be included in the distribution.  These files are not checked in because they
# are automatically generated.

set -e

# Check that we're being run from the right directory.
if test ! -f src/google/protobuf/stubs/common.h; then
  cat >&2 << __EOF__
Could not find source code.  Make sure you are running this script from the
root of the distribution tree.
__EOF__
  exit 1
fi

# Check that gtest is present.  Usually it is already there since the
# directory is set up as an SVN external.
#if test ! -e gtest; then
#  echo "Google Test not present.  Fetching gtest-1.5.0 from the web..."
#  curl https://codeload.github.com/google/googletest/tar.gz/release-1.5.0 | tar jx
#  mv googletest-release-1.5.0 gtest
#fi

set -ex

# TODO(kenton):  Remove the ",no-obsolete" part and fix the resulting warnings.
autoreconf -f -i -Wall,no-obsolete

rm -rf autom4te.cache config.h.in~
exit 0
