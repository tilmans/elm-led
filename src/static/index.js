const ws = new WebSocket("ws://localhost:7890");
ws.addEventListener("open", e => {
  console.info("WS Opened", e);
});
ws.addEventListener("message", e => {
  console.info("Message", e);
});
ws.addEventListener("close", e => {
  console.info("WS Closed", e);
});

// inject bundled Elm app into div#main
var Elm = require("../elm/Main");
const app = Elm.Main.embed(document.getElementById("main"));
app.ports.send.subscribe(bytes => {
  if (ws.readyState == 1) {
    const packet = new Uint8Array(bytes);
    ws.send(packet.buffer);
    ws.send(packet.buffer);
  }
});
