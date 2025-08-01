FROM eclipse-mosquitto:2.0

COPY etc/mosquitto/ /mosquitto/config/
RUN mkdir -p /mosquitto/log && chmod -R 777 /mosquitto/log

EXPOSE 9001
CMD ["mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
