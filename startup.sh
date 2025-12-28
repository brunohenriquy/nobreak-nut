#! /usr/bin/bash
set -e

PROFILE="${UPS_PROFILE:-tsshara}"

echo "================================================="
echo "Starting NUT with UPS profile: $PROFILE"
echo "================================================="

CONFIG_SRC="/config/$PROFILE"
CONFIG_DST="/etc/nut"

# Copy selected config
if [ ! -d "/config/$PROFILE" ]; then
    echo "ERROR: UPS profile '$PROFILE' not found in /config"
    exit 1
fi

echo ""
echo ""
echo ""
echo "[1/4] Preparing /etc/nut"
rm -rf "$CONFIG_DST"/*
cp -a "$CONFIG_SRC/"* "$CONFIG_DST/"

chown -R nut:nut /etc/nut
chmod 640 /etc/nut/*

echo "Config files loaded:"
ls -l /etc/nut

echo ""
echo ""
echo ""
echo "[2/4] Starting UPS driver(s)"

case "$PROFILE" in
  tsshara)
    echo "Starting $PROFILE driver"
    /lib/nut/nutdrv_qx -a tsshara
    if [ $? -ne 0 ]; then
        echo "Error running /lib/nut/nutdrv_qx"
    fi
    ;;
  sms)
    echo "Starting $PROFILE driver"
    /usr/lib/nut/sms_ser -a sms
    if [ $? -ne 0 ]; then
        echo "Error running /lib/nut/sms_ser"
    fi
    ;;
  *)
    echo "Unknown UPS profile: $PROFILE"
    exit 1
    ;;
esac

echo ""
echo ""
echo ""
echo "[3/4] Restarting NUT server"
/etc/init.d/nut-server restart
if [ $? -ne 0 ]; then
    echo "Error restarting nut-server"
fi

#sleep 10

echo ""
echo ""
echo ""
echo "[4/4] Running UPS"
upsc ${PROFILE}
if [ $? -ne 0 ]; then
    echo "Error running upsc"
fi

echo ""
echo ""
echo ""
echo "================================================="
echo "NUT started successfully for $PROFILE"
echo "================================================="

# Keep container alive
while true; do
  sleep 3600
done
