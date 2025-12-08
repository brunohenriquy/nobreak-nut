#! /usr/bin/bash
set -e

echo "=== Fixing runtime directory ==="
mkdir -p /run/nut
chown nut:nut /run/nut
chmod 770 /run/nut

echo "=== Starting NUT driver ==="
/usr/sbin/upsdrvctl -u nut start

echo "=== Starting NUT server (upsd) ==="
/usr/sbin/upsd -u nut

echo "=== Starting NUT monitor (upsmon) ==="
/usr/sbin/upsmon -u nut

echo "=== Testing UPS connection ==="
upsc tsshara

while true; do
  sleep 3600
done