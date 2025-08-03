# ------------ Stage 1: Build Node.js App ------------
FROM node:18-alpine AS nodebuilder

WORKDIR /app
COPY package.json ./
COPY server.js ./
RUN npm install


# ------------ Stage 2: Mosquitto + Node Runtime ------------
FROM eclipse-mosquitto:2.0

# Install WebSocket proxy requirements
RUN apk add --no-cache gettext nodejs npm

# Copy Mosquitto config
COPY etc/mosquitto /etc/mosquitto
COPY etc/mosquitto/mosquitto.conf /etc/mosquitto/mosquitto.conf


# Copy Node app from previous stage
COPY --from=nodebuilder /app /app

# Copy and set entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /app

EXPOSE 9001

ENTRYPOINT ["/entrypoint.sh"]
