FROM eclipse-mosquitto:2.0

# Install envsubst
RUN apt-get update && apt-get install -y gettext

# Copy configuration and app files
COPY etc/mosquitto/ /etc/mosquitto/
COPY server.js /app/server.js
COPY entrypoint.sh /entrypoint.sh
COPY package.json /app/package.json

WORKDIR /app

RUN npm install
RUN chmod +x /entrypoint.sh

EXPOSE 9001 10000

ENTRYPOINT ["/entrypoint.sh"]
