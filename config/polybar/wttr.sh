#!/bin/sh

WEATHER=`curl -s wttr.in/66503?format=3`
echo $WEATHER
