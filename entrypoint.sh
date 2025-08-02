#!/bin/sh

# Create config directory if needed
mkdir -p /etc/mosquitto


# Generate mosquitto config
envsubst < /app/etc/mosquitto/mosquitto.template.conf > /etc/mosquitto/mosquitto.conf

# Start Mosquitto
/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf &

# Start Node.js proxy
node /app/server.js
