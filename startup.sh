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

upsc ups
if [ $? -ne 0 ]; then
    echo "Error running upsc"
fi