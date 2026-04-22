const http = require("http");

const url = "https://tinyurl.com/2cnj72yj";
const port = 5908;

// ANSI colors
const cyan = "\x1b[1;96m";
const green = "\x1b[1;32m";
const yellow = "\x1b[1;33m";
const reset = "\x1b[0m";

console.clear();

// Console output
console.log(`\n\n${cyan}Navigate to this URL:\n${reset}`);
console.log(`${green}${url}${reset}\n`);
console.log(`${yellow}Open this Google Chrome and enter your url${reset}\n`);
console.log(`${cyan}Press Ctrl-C to exit 🛑\n\n${reset}`);

// Create HTTP server
const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "text/plain" });
  res.end("Server is running on port 5908\n");
});

// Start server
server.listen(port, () => {
  console.log(`${green}Server running on port ${port}${reset}`);
});

// Keep process alive (optional, server already does this)
setInterval(() => {}, 1000);
