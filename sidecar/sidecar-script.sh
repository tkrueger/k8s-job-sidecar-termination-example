#!/bin/bash

trap 'echo "SIGINT or SIGTERM received: exiting!" && exit 0' TERM INT 

while true; 
  do echo 'still here'
  sleep 2
done
