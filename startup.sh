#! /usr/bin/bash

# Run custom commands after container startup
/lib/nut/blazer_ser -a ups
if [ $? -ne 0 ]; then
    echo "Error running /lib/nut/blazer_ser"
fi

/etc/init.d/nut-server restart
if [ $? -ne 0 ]; then
    echo "Error restarting nut-server"
fi

sleep 10

upsc ups
if [ $? -ne 0 ]; then
    echo "Error running upsc"
fi

while true; do
  sleep 3600
done