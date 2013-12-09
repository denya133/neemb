#!/bin/bash

if [ ! -d "logs" ]; then
  mkdir logs
fi

cake build &>> logs/server.log
PORT=3000 coffee start.coffee &>> logs/server.log