FROM debian:bullseye

# Install Mosquitto and Node.js
RUN apt update && \
    apt install -y mosquitto nodejs npm

# Set working directory
WORKDIR /app

# Copy all files to container
COPY . .

# Install Node.js dependencies
RUN npm install

# Give execute permission to entrypoint
RUN chmod +x /entrypoint.sh

# Expose WebSocket proxy port
EXPOSE 10000

# Start Mosquitto and Node app
CMD ["/entrypoint.sh"]
