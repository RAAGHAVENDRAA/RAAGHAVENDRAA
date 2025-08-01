const http = require("http");
const httpProxy = require("http-proxy");
const WebSocket = require("ws");

// Create HTTP server (so Render sees port 3000)
const server = http.createServer((req, res) => {
  res.writeHead(200);
  res.end("MQTT WebSocket Proxy is running");
});

const proxy = httpProxy.createProxyServer({});

// Create WebSocket server on top of HTTP
const wss = new WebSocket.Server({ server, path: "/mqtt" });

wss.on("connection", (clientSocket, req) => {
  const backendSocket = new WebSocket("ws://localhost:1883");

  // Pipe data both ways
  clientSocket.on("message", (msg) => backendSocket.send(msg));
  backendSocket.on("message", (msg) => clientSocket.send(msg));

  clientSocket.on("close", () => backendSocket.close());
  backendSocket.on("close", () => clientSocket.close());

  backendSocket.on("error", (err) => console.error("Backend WS error:", err));
  clientSocket.on("error", (err) => console.error("Client WS error:", err));
});

// Start HTTP server on port 3000
server.listen(3000, () => {
  console.log("Proxy server running on port 3000");
});
