FROM debian:bullseye

# Install Mosquitto and Node.js
RUN apt update && \
    apt install -y mosquitto nodejs npm

# Set working directory inside container
WORKDIR /app

# Copy everything from your local project folder to /app
COPY . .

# Make sure the entrypoint is executable
RUN chmod +x entrypoint.sh

# Install Node dependencies
RUN npm install

EXPOSE 10000 9001

CMD ["./entrypoint.sh"]
