#!/bin/sh

# Build the image
eval "echo \"Building the image\""
eval "docker build . -t protobufbuild"
eval "echo \"Finished building the image\""

# Terminate any existing containers.
eval "echo \"Stopping previously ran containers and removing them\""
eval "docker container stop protobufBuild && docker container rm protobufBuild"
eval "echo \"Finished deleting previously ran containers.\""

# Run the image.
eval "echo \"Running the image.\""
eval "docker run --name protobufBuild protobufbuild"
eval "echo \"Completed running.\""

# go to the correct folder.
eval "echo \"Changing to src folder\""
eval "cd src"
eval "echo \"Completed changing to src folder.\""

# copy back out
eval "echo \"Copying libprotobuf-lite back out of the container.\""
eval "docker cp protobufBuild:/home/protobuf/src/.libs/libprotobuf-lite.a .libs"
eval "echo \"Finished copying.\""
eval "echo \"Exiting.\""