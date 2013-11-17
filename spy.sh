#!/bin/bash

# Read configuration
source $(pwd)/config

# Check options
if [[ $1 = '-h' || $1 = '--help' ]]; then
  hhelp
  exit 0
fi

for ARG in $@; do

  if [[ $ARG = '-v' || $ARG = '--verbose' ]]; then
    VERBOSE=1
    WRITER="| tee -a"
    shift
    continue
  fi
  if [[ $ARG = '-d' || $ARG = '--deep' ]]; then
    DEEP=1
    shift
    continue
  fi
  if [[ $ARG = '-o' || $ARG = '--output' ]]; then
    shift
    FILE=$1
    shift
  fi

done

# Set tower, room number and filename if any
if [[ ! -z $1 && ! -z $2 ]]; then
  TOWER=$1
  ROOM=$2
fi
if [[ -z $FILE ]]; then
  FILE=topology-$TOWER-$ROOM
fi

if [[ -f $FILE ]]; then
  rm $DIR/$FILE
fi
touch $DIR/$FILE

# Start spying
$ANAL

exit $?