#!/bin/sh

# Generate Mosquitto config from template
#envsubst < /app/etc/mosquitto/mosquitto.conf > /etc/mosquitto/mosquitto.conf

# Start Mosquitto in background
#/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf &

# Start the WebSocket proxy
#node /app/server.js


#!/bin/sh

envsubst < /app/etc/mosquitto/mosquitto.conf > /etc/mosquitto/mosquitto.conf
/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf &

sleep 2  # Give Mosquitto time to start

node /app/server.js
