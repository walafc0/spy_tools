#!/bin/bash

for CURRENT_TOWER in $TOWER; do

  for CURRENT_ROOM in $ROOM; do

    eval echo -e "Analyze room $CURRENT_TOWER-$CURRENT_ROOM $WRITER $DIR/$FILE"

    for CURRENT_STATION in $STATION; do

      eval echo "Analyse station number $CURRENT_STATION $WRITER $DIR/$FILE"

      SIZE=$(echo $CURRENT_STATION | wc -m)
      SIZE=$(($SIZE - 1))

      if [[ $SIZE -eq 1 ]]; then
        CURRENT_STATION="0$CURRENT_STATION"
      fi

      CURRENT=ari-$CURRENT_TOWER-$CURRENT_ROOM-$CURRENT_STATION
      RESULT=$(ssh $CURRENT -C -o UserKnownHostsFILE=/dev/null -o StrictHostKeyChecking=no -o ConnectTimeout=2 2> /dev/null < $FINGERER )
      RESULT=$(echo $RESULT | cut -d'.' -f 5)

      if [[ ! -z $RESULT ]]; then
        eval echo -e $RESULT $WRITER $DIR/$FILE
      fi

      if [[ $DEEP -eq 1 ]]; then
        RESULT=$(ssh $CURRENT -C -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ConnectTimeout=2 "bash -c $D_FINGERER" 2>/dev/null)
	if [[ ! -z $RESULT ]]; then
          eval echo -e $RESULT $WRITER $DIR/$FILE
	fi
      fi

    done;

  done;

done;

exit 0