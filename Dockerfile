FROM node:18

# Install Mosquitto
RUN apt-get update && apt-get install -y mosquitto

# Set working directory
WORKDIR /app

# Copy dependencies
COPY package.json .

# Install Node dependencies (e.g., ws)
RUN npm install

# Copy app code
COPY server.js .

# Copy Mosquitto config
COPY etc/mosquitto /etc/mosquitto

# Create Mosquitto log folder
RUN mkdir -p /mosquitto/log && chmod -R 777 /mosquitto/log

# Expose HTTP/WebSocket port
EXPOSE 3000

# Run Mosquitto and Node proxy
CMD mosquitto -c /etc/mosquitto/mosquitto.conf & npm start
