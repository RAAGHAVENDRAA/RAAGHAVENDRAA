#!/bin/sh

# Generate Mosquitto config from template
envsubst < /app/etc/mosquitto/mosquitto.template.conf > /etc/mosquitto/mosquitto.conf

# Start Mosquitto in background
/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf &

# Start the WebSocket proxy
node /app/server.js
