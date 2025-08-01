FROM eclipse-mosquitto:2.0

# Copy your full custom config
COPY etc/mosquitto/ /mosquitto/config/

# Create log directory to prevent crash
RUN mkdir -p /mosquitto/log && chmod -R 777 /mosquitto/log

# Set permissions for config files
RUN chmod -R 755 /mosquitto/config

# Expose WebSocket port
EXPOSE 9001

# Start Mosquitto using config
CMD ["mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
