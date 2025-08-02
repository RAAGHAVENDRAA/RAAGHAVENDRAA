FROM debian:bullseye

# Install Mosquitto and Node.js
RUN apt update && \
    apt install -y mosquitto nodejs npm curl && \
    npm install -g npm

WORKDIR /app

# Copy all project files
COPY . .

# Install Node dependencies
RUN ls -la && cat package.json && npm install


# Set entrypoint permissions
RUN chmod +x /entrypoint.sh

# Expose dynamic port
EXPOSE 10000

# Run the entrypoint
CMD ["/entrypoint.sh"]
