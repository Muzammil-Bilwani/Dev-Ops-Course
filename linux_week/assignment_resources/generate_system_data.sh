#!/bin/bash
# This script generates sample system data for testing the health monitor dashboard
# It creates files that can be used to simulate real system metrics

# Create directory for test data
mkdir -p test_data

# Generate sample CPU data (0-100%)
generate_cpu_data() {
  local base=$1
  local variance=$2
  local value=$(( base + (RANDOM % variance) - (variance/2) ))
  
  # Ensure within bounds
  if [ $value -lt 0 ]; then value=0; fi
  if [ $value -gt 100 ]; then value=100; fi
  
  echo $value
}

# Generate memory data
generate_memory() {
  # Total memory in KB
  echo "MemTotal:        8192000 kB" > test_data/memory
  local used=$(( 4000000 + (RANDOM % 2000000) ))
  echo "MemFree:         $(( 8192000 - used )) kB" >> test_data/memory
  echo "Cached:          1500000 kB" >> test_data/memory
  echo "Buffers:         350000 kB" >> test_data/memory
}

# Generate disk data
generate_disk() {
  echo "Filesystem      Size  Used Avail Use% Mounted on" > test_data/disk
  echo "/dev/sda1        50G   38G   12G  76% /" >> test_data/disk
  echo "/dev/sdb1        20G    8G   12G  42% /var/log" >> test_data/disk
  echo "/dev/sdc1       100G   28G   72G  28% /home" >> test_data/disk
}

# Generate network data
generate_network() {
  echo "eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500" > test_data/network
  echo "        inet 192.168.1.10  netmask 255.255.255.0  broadcast 192.168.1.255" >> test_data/network
  local rx=$(( (RANDOM % 20) + 10 ))
  local tx=$(( (RANDOM % 10) + 1 ))
  echo "        RX packets $rx  bytes $(( rx * 1024 * 1024 ))" >> test_data/network
  echo "        TX packets $tx  bytes $(( tx * 1024 * 1024 ))" >> test_data/network
}

# Generate load average data
generate_load() {
  local load1=$(awk "BEGIN {printf \"%.2f\", 1.5 + (0.5 * rand())}")
  local load5=$(awk "BEGIN {printf \"%.2f\", 1.2 + (0.5 * rand())}")
  local load15=$(awk "BEGIN {printf \"%.2f\", 1.0 + (0.5 * rand())}")
  echo "$load1 $load5 $load15" > test_data/loadavg
}

# Generate top processes data
generate_processes() {
  cat > test_data/top_processes << 'EOT'
USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
mongodb   12345 22.0 15.2 2145928 622544 ?     Ssl  Jun30 450:32 /usr/bin/mongod
www-data  23456 18.0 12.5 1854272 512356 ?     Ss   Jun30 387:21 nginx: master process
node      34567 15.0 10.3 1654208 422560 ?     Ssl  Jun30 321:18 node /app/server.js
root      45678  5.0  4.2  425172 172856 ?     Ss   Jun30 104:23 /usr/sbin/sshd
redis     56789  4.5  3.8  350128 155648 ?     Ssl  Jun30  98:12 /usr/bin/redis-server
EOT
}

# Generate alerts based on current CPU value
generate_alerts() {
  local cpu=$1
  local timestamp=$(date +"%H:%M:%S")
  
  # Clear previous alerts
  > test_data/alerts
  
  if [ $cpu -gt 80 ]; then
    echo "[$timestamp] CPU usage exceeded 80% (${cpu}%)" >> test_data/alerts
  fi
  
  # Add some static alerts for testing
  echo "[$(date -d "30 minutes ago" +"%H:%M:%S")] Memory usage exceeded 75% (78%)" >> test_data/alerts
  echo "[$(date -d "1 hour ago" +"%H:%M:%S")] Disk usage on / exceeded 75% (76%)" >> test_data/alerts
}

# Main loop to generate test data
echo "Generating test data in test_data/ directory..."
echo "Press Ctrl+C to stop"

while true; do
  # CPU usage values varying around different levels to simulate changes
  if [ $((RANDOM % 10)) -lt 7 ]; then
    # Normal range (40-70%)
    cpu=$(generate_cpu_data 55 30)
  else
    # High range (70-90%)
    cpu=$(generate_cpu_data 80 20)
  fi
  
  echo $cpu > test_data/cpu
  
  # Generate other system data
  generate_memory
  generate_disk
  generate_network
  generate_load
  generate_processes
  generate_alerts $cpu
  
  echo "Generated data with CPU at ${cpu}%"
  sleep 2
done
