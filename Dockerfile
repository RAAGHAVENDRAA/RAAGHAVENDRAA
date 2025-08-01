FROM eclipse-mosquitto:2.0

# Copy your full custom config
COPY etc/mosquitto/ /mosquitto/config/

# Make sure permissions are okay
RUN chmod -R 755 /mosquitto/config

EXPOSE 9001

CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
