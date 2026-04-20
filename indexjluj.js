#!/usr/bin/env node

const url = "https://tinyurl.com/2cnj72yj";

// ANSI colors (like echo -e)
const cyan = "\x1b[1;96m";
const green = "\x1b[1;32m";
const yellow = "\x1b[1;33m";
const reset = "\x1b[0m";

console.clear();

// Print message (same style as echo -e)
console.log(`\n\n${cyan}Navigate to this URL:\n${reset}`);
console.log(`${green}${url}${reset}\n`);
console.log(`${yellow}Open this Google Chrome and enter your url${reset}\n`);
console.log(`${cyan}Press Ctrl-C to exit 🛑\n\n${reset}`);

// Keep process alive
setInterval(() => {
  // idle loop to keep script running
}, 1000);

// Handle Ctrl+C nicely
process.on("SIGINT", () => {
  console.log(`\n\n${yellow}Exiting...${reset}`);
  process.exit(0);
});