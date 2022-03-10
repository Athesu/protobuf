Windows 10 WSL2 Linux Edition - Recompiling the Protobufs
-----------------------
Assumes you are starting completely from scratch and all the correct things are located in `C:/workspace/bcu_applications` (adjust paths as necessary):
  1. Control Panel => Turn Windows features on or off => Checkmark Windows Subsystem for Linux => Restart as needed.
  2. Microsoft Store => Search for Ubuntu => Install the "Ubuntu" (i.e: no versioning/numbers/extraneous words that follows the name).
  3. Open Ubuntu.
  4. Run the following commands after creating a username and password:
  
      1. sudo apt update
      2. sudo apt-get upgrade -y
      3. sudo apt-get install -y build-essential curl g++-multilib lib32z1-dev autoconf automake libtool make curl g++ unzip gcc-arm-none-eabi dos2unix
      4. sudo apt-get autoremove
      5. cd /mnt/c/bcu_applications/protobuf
      6. sudo dos2unix autogen.sh Makefile.am
      7. ./autogen.sh
      8. autoreconf -f -i -Wall,no-obsolete
      9. sudo ./configure --disable-shared --host=arm-none-eabi CPPFLAGS='-std=c++11 -mthumb -mlittle-endian -ggdb -mcpu=cortex-m3 -DGOOGLE_PROTOBUF_NO_RTTI -DGOOGLE_PROTOBUF_NO_STATIC_INITIALIZER -DGOOGLE_PROTOBUF_NO_THREAD_SAFETY' LDFLAGS='-mthumb -mcpu=cortex-m3 --specs=nosys.specs'
      10. cd src
      11. make -j8 libprotobuf.la
    