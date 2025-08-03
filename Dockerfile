FROM eclipse-mosquitto:2.0

# ✅ Use Alpine's package manager to install envsubst
RUN apk add --no-cache gettext

# Copy Mosquitto config
COPY etc/mosquitto/ /etc/mosquitto/

# Copy Node.js server
COPY server.js /app/server.js
COPY package.json /app/package.json
COPY entrypoint.sh /entrypoint.sh

WORKDIR /app

# Install Node.js dependencies
RUN npm install

# Ensure the startup script is executable
RUN chmod +x /entrypoint.sh

# Expose ports: 9001 (WebSocket), 10000 (HTTP status)
EXPOSE 9001 10000

# Start both Mosquitto and Node proxy
ENTRYPOINT ["/entrypoint.sh"]
