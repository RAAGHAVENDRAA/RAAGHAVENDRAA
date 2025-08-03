const http = require("http");
const WebSocket = require("ws");

const PORT = process.env.PORT || 10000;

// Create HTTP server
const server = http.createServer((req, res) => {
  res.writeHead(200);
  res.end("✅ MQTT WebSocket Proxy is running");
});

// WebSocket server
const wss = new WebSocket.Server({ server, path: "/mqtt" });

wss.on("connection", (clientSocket) => {
  console.log("🌐 Client connected");

  // Connect to Mosquitto WebSocket backend (assuming localhost inside container)
  const backendSocket = new WebSocket("ws://localhost:9001");

  backendSocket.on("open", () => {
    console.log("🔌 Connected to Mosquitto");

    // Forward client messages to backend
    clientSocket.on("message", (msg) => {
      backendSocket.send(msg);
    });

    // Forward backend messages to client
    backendSocket.on("message", (msg) => {
      clientSocket.send(msg);
    });
  });

  backendSocket.on("error", (err) => console.error("❌ Backend error:", err));
  clientSocket.on("error", (err) => console.error("❌ Client error:", err));

  clientSocket.on("close", () => {
    console.log("🔒 Client disconnected");
    backendSocket.close();
  });

  backendSocket.on("close", () => {
    console.log("🔌 Backend disconnected");
    clientSocket.close();
  });
});

server.listen(PORT, () => {
  console.log(`✅ MQTT WebSocket Proxy running on port ${PORT}`);
});
