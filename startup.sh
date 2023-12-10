#! /usr/bin/bash

# Run custom commands after container startup

echo "Running 1/3"
#/lib/nut/blazer_ser -a tsshara
#if [ $? -ne 0 ]; then
#    echo "Error running /lib/nut/blazer_ser"
#fi

/lib/nut/nutdrv_qx -a tsshara
if [ $? -ne 0 ]; then
    echo "Error running /lib/nut/nutdrv_qx"
fi
echo ""
echo ""
echo ""

echo "Running 2/3"
/etc/init.d/nut-server restart
if [ $? -ne 0 ]; then
    echo "Error restarting nut-server"
fi
echo ""
echo ""
echo ""

#sleep 10

echo "Running 3/3"
upsc tsshara
if [ $? -ne 0 ]; then
    echo "Error running upsc"
fi
echo ""
echo ""
echo ""

while true; do
  sleep 3600
done