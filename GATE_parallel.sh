#!/bin/bash

## Hello !
# This script runs multiple instances of GATE software.
# Author : Luis Ammour -- luis@ammour.net
# Date : 2016-03-11


## Instructions :
# This script assumes all your GATE macros files are included in the same
# directory (or subfolders) as your main macro
# 1. Place this script file anywhere
# 2. Run it with : `bash multiple_Gate.sh -n x ~/folder/yourMainMacro.mac`
# (note : -n means "x parallels GATEs")
# 3. Wait ...

## Script :

# 1. Modifies output files names using an alias set to an
# environnement variable
# 2. Sets the environnement variable
# 3. Starts GATE one time
# 4. Repeats steps 3 (x-1) times (see [Instructions - 2])

export TERM=linux
while getopts "n:" opt; do
  case "$opt" in
  n)  nb_simu=$OPTARG
      ;;
  esac
done
shift $((OPTIND-1))
[ "$1" = "--" ] && shift

macfile=$@
mainmac=$(basename $macfile)
loc=$(dirname $macfile)
cd $loc
sleep 3
echo 'Exécution du fichier ' $mainmac ', dans le répertoire ' $loc
mkdir outputs
pwd

## 3. Macros modifications
find -name "*.mac" -print | while read file ; do
  sed  -i "/setFileName/i\\/control\/getEnv RUN_ID" $file
  sed  -i "s@setFileName.*@setFileName outputs/{RUN_ID}@g" $file
done

# 6. Loop over steps 4 and 5
for PROC_ID in `seq 1 $nb_simu`
do

  # 4. Setting of environnement variable
  export RUN_ID=$PROC_ID

  ## 5. Gate execution
  Gate $mainmac &
  PID=$PID\ $!
  sleep 3

done

  ## 7. Waiting GATEs to end then copying of output files
  wait $PID
  sleep 3

echo 'Script ended !'
