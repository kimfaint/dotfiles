#!/bin/bash
echo $1 $2 $3 $4 > /tmp/a
if [ "$HOSTNAME" == "laptop" ]
then
	xrandr --output $4 --above $2 --auto
else
	xrandr --output $3 --right-of $1 --auto
fi
