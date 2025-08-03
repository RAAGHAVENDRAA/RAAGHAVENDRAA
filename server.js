const http = require("http");
const WebSocket = require("ws");

const PORT = process.env.PORT || 10000;

const server = http.createServer((req, res) => {
  res.writeHead(200);
  res.end("MQTT WebSocket Proxy is running my port");
});

const wss = new WebSocket.Server({ server, path: "/mqtt" });

wss.on("connection", (clientSocket) => {
  const backendSocket = new WebSocket("ws://localhost:9001");

  clientSocket.on("message", (msg) => backendSocket.send(msg));
  backendSocket.on("message", (msg) => clientSocket.send(msg));

  clientSocket.on("close", () => backendSocket.close());
  backendSocket.on("close", () => clientSocket.close());

  clientSocket.on("error", (err) => console.error("Client error:", err));
  backendSocket.on("error", (err) => console.error("Backend error:", err));
});

server.listen(PORT, () => {
  console.log(`✅ MQTT WebSocket Proxy running on port ${PORT}`);
});
