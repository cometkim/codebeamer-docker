#!/bin/sh

CB_USER=codebeamer

SRC_DIR=/usr/src/codebeamer
DEST_DIR=/opt/codebeamer

if [ -s $DEST_DIR ]
then
   echo "Copying initialized codeBeamer sources to working directory"
   cp -r $SRC_DIR/setup/* $DEST_DIR && rm -rf $SRC_DIR
   chown -R $CB_USER $DEST_DIR
else
   rm -rf $SRC_DIR
fi

echo "Starting codeBeamer server"
su $CB_USER -c "exec bin/cb" 
