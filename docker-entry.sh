#!/bin/sh

SRC_DIR=/usr/src/codebeamer
DEST_DIR=/opt/codebeamer

if [ -s $DEST_DIR ]
then
   echo "Copying codeBeamer sources to working directory"
   cp -r $SRC_DIR/setup/* $DEST_DIR && rm -rf $SRC_DIR
else
   rm -rf $SRC_DIR
fi

echo "Starting codeBeamer server"
exec bin/cb 
