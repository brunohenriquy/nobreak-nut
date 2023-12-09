#! /usr/bin/bash

/lib/nut/blazer_ser -a ups || true
/etc/init.d/nut-server restart || true
upsc ups || true