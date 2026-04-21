const { execSync } = require("child_process");
const readline = require("readline");

// Colors
const G = "\x1b[1;92m";
const R = "\x1b[1;91m";
const W = "\x1b[1;97m";
const N = "\x1b[0m";

// Prompt
function ask(q) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });
  return new Promise((res) =>
    rl.question(q, (ans) => {
      rl.close();
      res(ans.trim());
    })
  );
}

// Run command
function run(cmd) {
  try {
    execSync(cmd, { stdio: "inherit", shell: "/bin/bash" });
  } catch {
    console.log(R + "Command failed: " + cmd + N);
    process.exit(1);
  }
}

// Clear screen
function clear() {
  process.stdout.write("\x1Bc");
}

// Banner
clear();
console.log(`${G} ╦ ╦┬┌┐┌ ${R}╔╦╗┌─┐┬─┐┌┬┐┬ ┬─┐ ┬`);
console.log(`${G} ║║║││││  ${R}║ ├┤ ├┬┘││││ │┌┴┬┘`);
console.log(`${G} ╚╩╝┴┘└┘  ${R}╩ └─┘┴└─┴ ┴└─┘┴ └─`);
console.log(`${G} [+] YouTube: ${R}TermuxProfessor`);
console.log(`${G} [+] Github: ${R}termuxprofessor${W}\n`);

(async () => {
  const input = await ask("Does WIN10TP.iso exist in your Download folder? (Yes/No): ");

  if (/^(yes|y)$/i.test(input)) {
    clear();

    run("termux-wake-lock");
    run("pkg install x11-repo -y");
    run("pkg install qemu-system-x86_64 -y");

    clear();
    console.log(`${G}1] Allow Storage Permission To Termux.${N}`);
    await new Promise(r => setTimeout(r, 3000));

    clear();
    const ram = await ask("Select RAM size in MB (Ex: 1024): ");

    console.log("[+] Server Is Running....");
    console.log(`${R}Your Server IP is: 127.0.0.1:2${N}`);

    run(`qemu-system-x86_64 -m ${ram} -cdrom storage/downloads/WIN10TP.iso -vnc 127.0.0.1:2`);

  } else if (/^(no|n)$/i.test(input)) {
    console.log(`${R}1. First download WIN10TP.iso from:${N} ${G}http://bit.ly/wintermux`);
    console.log("2. Put WIN10TP.iso file into Download folder.");
    process.exit(2);

  } else {
    console.log(`${R}Invalid Option${N}`);
    process.exit(1);
  }
})();
