FROM node:18

# Install Mosquitto
RUN apt-get update && apt-get install -y mosquitto

# Create app directory
WORKDIR /app

# Copy Mosquitto config
COPY etc/mosquitto /etc/mosquitto

# Copy Node.js app
COPY server.js .

# Open HTTP/WebSocket port
EXPOSE 3000

# Run both Mosquitto and Node.js
CMD mosquitto -c /etc/mosquitto/mosquitto.conf & node server.js
