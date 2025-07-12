#!/bin/bash
# System Health Monitor Dashboard
# This script displays system health metrics in real-time

# Configuration
refresh_rate=3  # Refresh interval in seconds
use_test_data=true  # Set to false to use real system data

# Terminal color codes
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
NC="\033[0m" # No Color
BOLD="\033[1m"

# Function to clear the screen and reset cursor position
clear_screen() {
  tput clear
  tput cup 0 0
}

# Function to create a progress bar
create_bar() {
  local percent=$1
  local width=40
  local bar_width=$((percent * width / 100))
  local empty_width=$((width - bar_width))
  
  # Create the filled portion of the bar
  local bar=""
  for ((i=0; i<bar_width; i++)); do
    bar="${bar}█"
  done
  
  # Create the empty portion of the bar
  for ((i=0; i<empty_width; i++)); do
    bar="${bar}░"
  done
  
  echo "$bar"
}

# Function to determine status color based on percentage
get_status_color() {
  local percent=$1
  local status_text=""
  
  if [ "$percent" -lt 70 ]; then
    echo -e "${GREEN}[OK]${NC}"
  elif [ "$percent" -lt 85 ]; then
    echo -e "${YELLOW}[WARNING]${NC}"
  else
    echo -e "${RED}[CRITICAL]${NC}"
  fi
}

# Function to read CPU usage
read_cpu() {
  if [ "$use_test_data" = true ] && [ -f "test_data/cpu" ]; then
    cat test_data/cpu
  else
    # Get CPU idle percentage and convert to usage percentage
    top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}'
  fi
}

# TODO: Add functions to read memory, disk, network, and load average data

# Function to display the dashboard header
display_header() {
  local hostname=$(hostname)
  local date_str=$(date +"%Y-%m-%d %H:%M:%S")
  local uptime_str=$(uptime -p)
  
  echo -e "╔════════════ ${BOLD}SYSTEM HEALTH MONITOR v1.0${NC} ════════════╗  [R]efresh rate: ${refresh_rate}s"
  echo -e "║ Hostname: $hostname          Date: $date_str ║  [F]ilter: All"
  echo -e "║ Uptime: $uptime_str               ║  [Q]uit"
  echo -e "╚═══════════════════════════════════════════════════════════════════════╝"
  echo ""
}

# Function to display CPU information
display_cpu() {
  local cpu_usage=$(read_cpu)
  local cpu_bar=$(create_bar $cpu_usage)
  local status=$(get_status_color $cpu_usage)
  
  echo -e "CPU USAGE: ${BOLD}${cpu_usage}%${NC} $cpu_bar $status"
  echo "  Process: mongod (22%), nginx (18%), node (15%)"
  echo ""
}

# TODO: Add functions to display memory, disk, network, and load average information

# TODO: Add functions to handle keyboard input for interactive features

# Main loop
trap "tput cnorm; exit" INT TERM QUIT
tput civis # Hide cursor

while true; do
  clear_screen
  display_header
  display_cpu
  # TODO: Call other display functions for memory, disk, etc.
  
  echo -e "\nPress 'h' for help, 'q' to quit"
  
  # Wait for refresh_rate seconds before updating again
  sleep $refresh_rate
done
