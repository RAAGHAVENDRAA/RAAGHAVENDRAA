#!/bin/sh

# Create config directory if needed
mkdir -p /etc/mosquitto

# Replace ${PORT} in the template and copy to Mosquitto
envsubst < /app/etc/mosquitto/mosquitto.template.conf > /etc/mosquitto/mosquitto.conf

# Start Mosquitto in the background
/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf &

# Start Node.js server
node /app/server.js
