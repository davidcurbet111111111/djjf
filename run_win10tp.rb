#!/usr/bin/env ruby
# Do not copy or edit code read LICENSE First.
# This Script is coded by Termux Professor (Youtuber)

def clear_screen
  print "\e[H\e[2J"
end

def print_banner
  puts "\e[1;92m ╦ ╦┬┌┐┌ \e[1;91m╔╦╗┌─┐┬─┐┌┬┐┬ ┬─┐ ┬"
  puts "\e[1;92m ║║║││││ \e[1;91m║ ├┤ ├┬┘││││ │┌┴┬┘"
  puts "\e[1;92m ╚╩╝┴┘└┘ \e[1;91m╩ └─┘┴└─┴ ┴└─┘┴ └─"
  puts "\e[1;92m [+] YouTube: \e[1;91mTermuxProfessor"
  puts "\e[1;92m [+] Github: \e[1;91mtermuxprofessor\e[1;97m"
  puts ""
end

def ask(question)
  print question
  gets.strip
end

def run_command(cmd)
  system(cmd)
  unless $?.success?
    puts "\e[1;91mCommand failed: #{cmd}"
    exit 1
  end
end

clear_screen
print_banner

input = ask("Does WIN10TP.iso File In Your Download Folder?(Yes/No) : ")

if input =~ /^(yes|y)$/i
  clear_screen
  home = ENV['HOME'] || Dir.home
  Dir.chdir(home)

  # Acquire wake lock
  run_command("termux-wake-lock")

  # Install required packages
  run_command("pkg install x11-repo -y")
  run_command("pkg install qemu-system-x86_64 -y")

  clear_screen
  puts "\e[1;92m1] Allow Storage Permission To Termux."
  sleep 3
  clear_screen

  ram = ask("Select RAM size In MB Ex 1GB = 1024 : ")

  puts "[+] Server Is Running...."
  puts "Your Server IP is:\e[1;91m 127.0.0.1:2\e[0m"

  iso_path = File.join(home, "storage", "downloads", "WIN10TP.iso")

  # Run QEMU with specified RAM and ISO
  exec("qemu-system-x86_64 -m #{ram} -cdrom #{iso_path} -vnc 127.0.0.1:2")

elsif input =~ /^(no|n)$/i
  puts "\e[1;91m1. First Download WIN10TP.iso file from this Link: \e[1;92mhttp://bit.ly/wintermux\e[0m"
  puts "2. Put WIN10TP.iso file into download folder."
  exit 2
else
  puts "\e[1;91mInvalid Option\e[0m"
  exit 1
end
