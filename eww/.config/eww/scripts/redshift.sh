#!/usr/bin/env bash

NORMAL=5800
NIGHT=3500

DARKER=""
if [[ $1 == "darker" ]];then
  DARKER="darker"
fi

function TRANSITION() {
  LEVEL=0
  AMT=""
  if [[ $1 == $NORMAL ]];then
    LEVEL=$NIGHT
    AMT="+ 100"
  else
    LEVEL=$NORMAL
    AMT="- 100"
  fi
  # notify-send $1
  while [[ $LEVEL != $1 ]];do
    # echo $LEVEL
    redshift -P -O $LEVEL
    sleep 0.01 ## sleep does not seem to work..
    LEVEL=$(($LEVEL $AMT))
  done 
  if [[ $1 == $NIGHT ]];then
      if [[ $DARKER == "darker" ]];then
        redshift -P -O $1 -b 0.6
      else
        redshift -P -O $1
      fi
    else
    redshift -P -O $1
  fi

}

FILE=/tmp/redshift

if [[ -f "$FILE" ]];then
  echo "fuck you"
else
  echo normal > $FILE
fi

ACTIVE=$(cat $FILE)
echo "this shit is.. $ACTIVE"

if [[ $ACTIVE == "night" ]];then
    redshift -P -O $NIGHT
    TRANSITION $NORMAL
    # redshift -O $NORMAL
    echo normal > $FILE
else
    redshift -P -O $NORMAL
    TRANSITION $NIGHT
    # redshift -O $NIGHT
    echo night > $FILE
fi
# while [[ true ]]; do
# echo hello
# done
