FROM debian:bullseye

# Install Mosquitto and Node.js
RUN apt update && \
    apt install -y mosquitto nodejs npm curl && \
    npm install -g npm

WORKDIR /app

# Copy everything into container
COPY . .

# Install only if package.json exists
RUN ls -la
RUN cat package.json
RUN npm install


RUN chmod +x /entrypoint.sh

EXPOSE 10000

CMD ["./entrypoint.sh"]
