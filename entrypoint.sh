#!/bin/sh

# Generate Mosquitto config from template
#envsubst < /app/etc/mosquitto/mosquitto.conf > /etc/mosquitto/mosquitto.conf

# Start Mosquitto in background
#/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf &

# Start the WebSocket proxy
#node /app/server.js


#!/bin/sh

# Start Mosquitto with correct WebSocket config
/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf &
mosquitto -c /etc/mosquitto/mosquitto.conf
# Wait a bit to ensure Mosquitto is ready
sleep 2

# Start Node.js proxy server
node /app/server.js

