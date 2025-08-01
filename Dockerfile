FROM eclipse-mosquitto:2.0

# Copy Mosquitto config and credentials
COPY etc/mosquitto/ /mosquitto/config/

# Create log directory so mosquitto doesn't crash
RUN mkdir -p /mosquitto/log && chmod -R 777 /mosquitto/log

# Set permissions for config
RUN chmod -R 755 /mosquitto/config

# WebSocket port
EXPOSE 9001

# Use mosquitto binary (not /usr/sbin/mosquitto)
CMD ["mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
