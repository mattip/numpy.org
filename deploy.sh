#!/bin/bash

# Execute getopt on the arguments
PARSED_OPTIONS=$(getopt -n "$0"  -o ht: --long "help,tag:"  -- "$@")
 
#Bad arguments, something has gone wrong with the getopt command.
if [ $? -ne 0 ];
then
  exit 1
fi
 
# A little magic, necessary when using getopt.
eval set -- "$PARSED_OPTIONS"

usage() {
      echo "usage $0"
      echo "    "
   exit 1; 
}
 
while true;
do
  case "$1" in
 
    -h|--help)
        usage
     shift;;
 
    -1|--one)
      echo "One"
      shift;;
 
    -2|--two)
      echo "Dos"
      shift;;
 
    -3|--three)
      echo "Tre"
 
      # We need to take the option of the argument "three"
      if [ -n "$2" ];
      then
        echo "Argument: $2"
      fi
      shift 2;;
 
    --)
      shift
      break;;
  esac
done


