## Linux Essentials for DevOps

- Navigating Linux using web terminals
- Creating/editing files, permissions, basic scripting
- Running and automating shell commands
- Hands-on: Write simple bash scripts and task automation

#### Navigating Linux using web terminals

We will be using web-based terminals to practice Linux commands. This allows you to run commands without needing a local Linux installation.

You can access the terminal at the following link:
https://linuxsurvival.com/linux-tutorial-introduction/

### Linux Commands Overview

| Command   | Description                          | Example                         |
| --------- | ------------------------------------ | ------------------------------- |
| `pwd`     | Print working directory              | `pwd`                           |
| `ls`      | List files and directories           | `ls -l`                         |
| `cd`      | Change directory                     | `cd /path/to/directory`         |
| `mkdir`   | Create a new directory               | `mkdir new_folder`              |
| `touch`   | Create a new file                    | `touch new_file.txt`            |
| `rm`      | Remove a file or directory           | `rm file.txt`                   |
| `cp`      | Copy files or directories            | `cp source.txt destination.txt` |
| `mv`      | Move or rename files or directories  | `mv old_name.txt new_name.txt`  |
| `chmod`   | Change file permissions              | `chmod 755 script.sh`           |
| `chown`   | Change file owner                    | `chown user:group file.txt`     |
| `cat`     | Concatenate and display file content | `cat file.txt`                  |
| `nano`    | Text editor for editing files        | `nano file.txt`                 |
| `grep`    | Search for patterns in files         | `grep 'text' file.txt`          |
| `find`    | Search for files and directories     | `find /path -name 'filename'`   |
| `echo`    | Display a line of text               | `echo "Hello World"`            |
| `history` | Show command history                 | `history`                       |
| `man`     | Display manual pages for commands    | `man ls`                        |
| `top`     | Display running processes            | `top`                           |
| `more`    | View file content page by page       | `more file.txt`                 |

### Creating/Editing Files, Permissions, Basic Scripting

#### Creating and Editing Files

You can create and edit files using the `touch` command to create a file and `nano` or `vim` to edit it.

```bash
# Create a new file
touch myfile.txt
# Edit the file using nano
nano myfile.txt
```

#### File Permissions

File permissions control who can read, write, or execute a file. You can change permissions using the `chmod` command.

```bash
# Change permissions to read, write, and execute for the owner, and read and execute for group and others
chmod 755 myfile.txt
```

#### Permissions Breakdown

| Permission    | Symbol | Numeric Value |
| ------------- | ------ | ------------- |
| Read          | r      | 4             |
| Write         | w      | 2             |
| Execute       | x      | 1             |
| No permission | -      | 0             |
| Owner         | u      |               |
| Group         | g      |               |
| Others        | o      |               |

Permissions Example:

Permissions can be set using numeric values or symbolic notation. For example, `chmod 755 myfile.txt` sets the permissions to read, write, and execute for the owner, and read and execute for group and others.

More examples of setting permissions snippet:

![alt text](https://phoenixnap.com/kb/wp-content/uploads/2021/04/file-permission-syntax-explained.jpg)

```bash
# Set read and write permissions for the owner, and read for group and others
chmod 644 myfile.txt
```

![alt text](https://tecadmin.net/tutorial/wp-content/uploads/2018/03/linux-file-permissions.png)

#### Basic Scripting

You can write simple bash scripts to automate tasks. Create a script file with the `.sh` extension and make it executable.

```bash
# Create a new script file
touch myscript.sh
# Make it executable
chmod +x myscript.sh
# Edit the script using nano
nano myscript.sh
```

Add the following content to `myscript.sh`:

```bash#!/bin/bash
# This is a simple script
echo "Hello, World!"
```

Run the script using:

```bash
./myscript.sh
```

### Running and Automating Shell Commands

You can run shell commands directly in the terminal or automate them using scripts. To automate tasks, you can create a script file and schedule it using `cron` for periodic execution.

#### Running Shell Commands

You can run shell commands directly in the terminal. For example, to list files in the current directory, you can use:

```bash
ls -l
```

#### Automating Shell Commands with Cron

You can use `cron` to schedule tasks to run at specific intervals. To edit the cron jobs, use:

```bash
crontab -e
```

Add a line to run a script every day at 2 AM:

```bash
0 2 * * * /path/to/myscript.sh
```

### Bash Scripting Prerequisites

Before diving into creating complex bash scripts, it's important to understand these fundamental concepts:

#### 1. Variables and Data Types

Variables in bash don't have explicit types and are treated as strings by default.

```bash
# Declaring variables
name="John"
age=30
today=$(date)  # Command substitution

# Using variables
echo "Hello, $name! You are $age years old."
echo "Today is $today"
```

#### 2. Control Structures

Bash supports standard control structures like conditionals and loops.

**Conditionals:**

```bash
if [ "$age" -gt 18 ]; then
    echo "You are an adult."
elif [ "$age" -eq 18 ]; then
    echo "You just became an adult."
else
    echo "You are a minor."
fi
```

**Loops:**

```bash
# For loop
for i in {1..5}; do
    echo "Count: $i"
done

# While loop
count=1
while [ $count -le 5 ]; do
    echo "Count: $count"
    ((count++))
done
```

#### 3. Functions

Functions help organize code into reusable blocks:

```bash
# Defining a function
greeting() {
    local name="$1"  # First parameter
    echo "Hello, $name!"
}

# Calling a function
greeting "Sarah"
```

#### 4. Command Line Arguments

Scripts can accept arguments from the command line:

```bash
# $1, $2, etc. refer to positional arguments
# $0 refers to the script name
echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
echo "All arguments: $@"
echo "Number of arguments: $#"
```

#### 5. Exit Status and Error Handling

Every command returns an exit status (0 for success, non-zero for failure):

```bash
command
if [ $? -eq 0 ]; then
    echo "Command succeeded"
else
    echo "Command failed"
fi
```

### Hands-on: Write Simple Bash Scripts and Task Automation

Now it's time to practice what you've learned. Create a simple bash script that performs the following tasks:

1. Create a new directory named `my_project`.
2. Inside `my_project`, create a file named `README.md`.
3. Write a message "This is my project" into `README.md`.
4. Change the permissions of `README.md` to read and write for the owner, and read for group and others.
5. Create a script that lists all files in `my_project` and outputs the result to a file named `file_list.txt`.

```bash
#!/bin/bash
# Create a new directory
mkdir my_project
# Change into the new directory
cd my_project
# Create a README.md file
touch README.md
# Write a message into README.md
echo "This is my project" > README.md
# Change permissions of README.md
chmod 644 README.md
# List all files and output to file_list.txt
ls -l > file_list.txt
```

### Bash Scripting Practice Questions

Try to solve these questions to strengthen your bash scripting skills:

1. What command would you use to find all files in the `/var/log/` directory that contain the word "error"?

2. Write a bash script that creates a backup of all `.txt` files in the current directory to a folder called `backups`.

3. How would you modify permissions so that a file is readable by everyone, writable only by the owner, and executable by the owner and group?

4. Create a one-line command that displays the top 5 largest files in the current directory.

5. Write a bash script that monitors CPU usage and sends an alert if it exceeds 80% for more than 2 minutes.

6. How would you schedule a script to run every Monday at 3:00 AM using cron?

7. Write a command to find all files that were modified in the last 24 hours.

8. Create a bash script that takes a filename as an argument and tells you whether it's a regular file, directory, or another type of file.

9. How would you search for files containing specific text across multiple subdirectories?

10. Write a bash script that prints the total disk space used by each user in the `/home` directory.

### Solutions to Practice Questions

#### Solution 1: Find files containing "error" in `/var/log/`

```bash
grep -r "error" /var/log/
# Alternative with find and grep
find /var/log/ -type f -exec grep -l "error" {} \;
```

**Explanation:**

- The `-r` flag makes `grep` search recursively through directories
- This command is useful for troubleshooting system issues by examining log files
- In production environments, you might pipe this to `less` when dealing with many results: `grep -r "error" /var/log/ | less`

#### Solution 2: Backup .txt files

```bash
#!/bin/bash
# Create backups directory if it doesn't exist
mkdir -p backups
# Copy all .txt files to the backups directory
find . -type f -name "*.txt" -exec cp {} backups/ \;
echo "Backup of all .txt files completed"
```

**Enhanced Version:**

```bash
#!/bin/bash
# Script to backup text files with timestamp

# Create timestamped backup directory
timestamp=$(date +"%Y%m%d_%H%M%S")
backup_dir="backups_$timestamp"

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Count files to backup
file_count=$(find . -type f -name "*.txt" | wc -l)
echo "Found $file_count text files to backup"

# Copy all .txt files to the backup directory with progress
counter=0
for file in $(find . -type f -name "*.txt"); do
    cp "$file" "$backup_dir/"
    ((counter++))
    echo -ne "Progress: $counter/$file_count files copied\r"
done

echo -e "\nBackup completed! Files saved to $backup_dir"
```

#### Solution 3: Modify permissions (readable by all, writable only by owner, and executable by owner & group)

```bash
chmod 754 filename
# Alternative using symbolic notation
chmod u=rwx,g=rx,o=r filename
```

**Explanation:**

- The permission `754` breaks down as:
  - `7` (rwx = 4+2+1) for owner: full permissions
  - `5` (r-x = 4+0+1) for group: read and execute only
  - `4` (r-- = 4+0+0) for others: read only
- This permission scheme is commonly used for scripts that:
  - Need to be run by both the owner and group members
  - Should be readable but not executable by others
  - Should only be modifiable by the owner

#### Solution 4: Display top 5 largest files in the current directory

```bash
find . -type f -exec du -h {} \; | sort -rh | head -n 5
# Alternative using ls
ls -lhS | head -n 6 | tail -n 5
```

**Explanation:**

- `du -h`: Shows disk usage in human-readable format
- `sort -rh`: Sorts numerically in reverse order with human-readable sizes
- DevOps application: Useful for identifying space hogs when a disk is filling up
- Production example:
  ```bash
  # Find the top 5 largest files in the entire system (requires sudo)
  sudo find / -type f -exec du -h {} \; 2>/dev/null | sort -rh | head -n 5
  ```

#### Solution 5: Monitor CPU usage

```bash
#!/bin/bash
# Script to monitor CPU usage and send alert if over 80% for more than 2 minutes

threshold=80
duration_seconds=120
check_interval=10
counter=0

echo "Starting CPU monitoring script at $(date)"

while true; do
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    cpu_integer=${cpu_usage%.*}

    echo "$(date): CPU usage: $cpu_integer%"

    if [ "$cpu_integer" -gt "$threshold" ]; then
        counter=$((counter + check_interval))
    else
        counter=0
    fi

    if [ "$counter" -ge "$duration_seconds" ]; then
        echo "ALERT: CPU usage above $threshold% for more than 2 minutes!" | tee alert.log
        # Send email alert (if mail command is available)
        echo "ALERT: CPU usage above $threshold% for more than 2 minutes!" | mail -s "CPU Alert" admin@example.com
        counter=0
    fi

    sleep $check_interval
done
```

**Real-world application:**

- This script can be used as a simple monitoring solution for critical servers
- In production environments, you might:
  - Log the data to a file for trend analysis
  - Include server name and additional system metrics
  - Send alerts via Slack, SMS, or integrate with monitoring systems like Prometheus
  - Add parameters that can be modified without editing the script:
    ```bash
    #!/bin/bash
    # Usage: ./monitor_cpu.sh [threshold] [duration_seconds] [check_interval]
    threshold=${1:-80}
    duration_seconds=${2:-120}
    check_interval=${3:-10}
    # Rest of the script remains the same
    ```

#### Solution 6: Schedule a script to run every Monday at 3:00 AM using cron

```bash
# Edit crontab
crontab -e
# Add this line
0 3 * * 1 /path/to/script.sh
```

**Cron format explanation:**

```
┌───────────── minute (0 - 59)
│ ┌───────────── hour (0 - 23)
│ │ ┌───────────── day of the month (1 - 31)
│ │ │ ┌───────────── month (1 - 12)
│ │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday)
│ │ │ │ │
│ │ │ │ │
│ │ │ │ │
* * * * * command to execute
```

**Common cron examples:**

```bash
# Run every minute
* * * * * /path/to/script.sh

# Run every hour at minute 0
0 * * * * /path/to/script.sh

# Run at 2:30 AM daily
30 2 * * * /path/to/script.sh

# Run at midnight on the first day of each month
0 0 1 * * /path/to/script.sh

# Run every weekday (Monday through Friday) at 6:00 PM
0 18 * * 1-5 /path/to/script.sh
```

#### Solution 7: Find files modified in the last 24 hours

```bash
find . -type f -mtime -1
# Alternative with -mmin for minutes
find . -type f -mmin -1440
```

**Explanation:**

- `-mtime -1` finds files modified less than 1 day ago
- `-mmin -1440` finds files modified less than 1440 minutes (24 hours) ago
- DevOps use case: Identifying recent changes for troubleshooting

**Extended example:**

```bash
# Find files modified in the last hour and save the list
find /var/www -type f -mmin -60 > recent_changes.txt

# Find files larger than 100MB modified in the last day
find /home -type f -size +100M -mtime -1 -exec ls -lh {} \;
```

#### Solution 8: Check file type

```bash
#!/bin/bash
# Script to check file type

if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename="$1"

if [ ! -e "$filename" ]; then
    echo "$filename does not exist"
    exit 1
fi

echo "=== File Information for: $filename ==="

# Basic file type
if [ -f "$filename" ]; then
    echo "Type: Regular file"
elif [ -d "$filename" ]; then
    echo "Type: Directory"
elif [ -L "$filename" ]; then
    echo "Type: Symbolic link → $(readlink -f "$filename")"
elif [ -p "$filename" ]; then
    echo "Type: Named pipe"
elif [ -b "$filename" ]; then
    echo "Type: Block device"
elif [ -c "$filename" ]; then
    echo "Type: Character device"
elif [ -S "$filename" ]; then
    echo "Type: Socket"
else
    echo "Type: Unknown"
fi

# Permissions and ownership
echo "Permissions: $(ls -l "$filename" | cut -d ' ' -f 1) ($(stat -c '%a' "$filename"))"
echo "Owner: $(stat -c '%U' "$filename")"
echo "Group: $(stat -c '%G' "$filename")"

# Size and timestamps
echo "Size: $(du -h "$filename" | cut -f 1)"
echo "Created: $(stat -c '%y' "$filename")"
echo "Modified: $(stat -c '%y' "$filename")"
echo "Accessed: $(stat -c '%x' "$filename")"

# For regular files, show file type
if [ -f "$filename" ]; then
    echo "Content type: $(file -b "$filename")"

    # For text files, show a preview
    if file "$filename" | grep -q "text"; then
        echo -e "\nContent preview (first 5 lines):"
        head -n 5 "$filename"
    fi
fi

# For directories, show content count
if [ -d "$filename" ]; then
    file_count=$(find "$filename" -type f | wc -l)
    dir_count=$(find "$filename" -type d | wc -l)
    echo "Contains: $file_count files, $dir_count directories"
fi
```

**Enhanced version with more details:**

```bash
#!/bin/bash
# Script to check file type and provide detailed information

if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename="$1"

if [ ! -e "$filename" ]; then
    echo "$filename does not exist"
    exit 1
fi

echo "=== File Information for: $filename ==="

# Basic file type
if [ -f "$filename" ]; then
    echo "Type: Regular file"
elif [ -d "$filename" ]; then
    echo "Type: Directory"
elif [ -L "$filename" ]; then
    echo "Type: Symbolic link → $(readlink -f "$filename")"
elif [ -p "$filename" ]; then
    echo "Type: Named pipe"
elif [ -b "$filename" ]; then
    echo "Type: Block device"
elif [ -c "$filename" ]; then
    echo "Type: Character device"
elif [ -S "$filename" ]; then
    echo "Type: Socket"
else
    echo "Type: Unknown"
fi

# Permissions and ownership
echo "Permissions: $(ls -l "$filename" | cut -d ' ' -f 1) ($(stat -c '%a' "$filename"))"
echo "Owner: $(stat -c '%U' "$filename")"
echo "Group: $(stat -c '%G' "$filename")"

# Size and timestamps
echo "Size: $(du -h "$filename" | cut -f 1)"
echo "Created: $(stat -c '%y' "$filename")"
echo "Modified: $(stat -c '%y' "$filename")"
echo "Accessed: $(stat -c '%x' "$filename")"

# For regular files, show file type
if [ -f "$filename" ]; then
    echo "Content type: $(file -b "$filename")"

    # For text files, show a preview
    if file "$filename" | grep -q "text"; then
        echo -e "\nContent preview (first 5 lines):"
        head -n 5 "$filename"
    fi
fi

# For directories, show content count
if [ -d "$filename" ]; then
    file_count=$(find "$filename" -type f | wc -l)
    dir_count=$(find "$filename" -type d | wc -l)
    echo "Contains: $file_count files, $dir_count directories"
fi
```

#### Solution 9: Search for text in files across multiple subdirectories

```bash
grep -r "search text" .
# Alternative using find
find . -type f -exec grep -l "search text" {} \;
```

**Advanced usage:**

```bash
# Search for text only in specific file types
find . -type f -name "*.conf" -exec grep -l "search text" {} \;

# Search with context (3 lines before and after)
grep -r -A 3 -B 3 "error" /var/log/

# Search and exclude certain directories
grep -r "TODO" --include="*.js" --exclude-dir="node_modules" .

# Count occurrences by file
grep -r "WARNING" /var/log/ | cut -d: -f1 | sort | uniq -c | sort -nr
```

#### Solution 10: Print disk space used by each user in /home

```bash
#!/bin/bash
# Script to print disk space usage by user in /home

echo "Disk space usage by user in /home:"
echo "--------------------------------"

# Check if user has permission to access /home
if [ ! -r "/home" ]; then
    echo "Error: You don't have permission to access /home"
    exit 1
fi

# Get list of users with home directories
users=$(ls -l /home | grep '^d' | awk '{print $3}')

# Calculate disk space for each user
for user in $users; do
    user_home="/home/$user"
    if [ -d "$user_home" ]; then
        usage=$(du -sh "$user_home" 2>/dev/null | cut -f1)
        echo "$user: $usage"
    fi
done

# Sort by size (optional)
echo -e "\nSorted by size:"
du -sh /home/* 2>/dev/null | sort -hr
```

**Enhanced version with reporting features:**

```bash
#!/bin/bash
# Enhanced script to analyze and report user disk usage

report_file="disk_usage_report_$(date +%Y%m%d).txt"
threshold_gb=5  # Alert if usage exceeds this value in GB

echo "Generating disk usage report for /home..."
echo "Disk Usage Report - Generated on $(date)" > "$report_file"
echo "=======================================" >> "$report_file"

# Check for sudo privileges
if [ "$EUID" -ne 0 ]; then
    echo "Warning: Not running as root. Some directories may not be accessible."
    echo "Warning: Not running as root. Some directories may not be accessible." >> "$report_file"
fi

# Get total disk space
total_space=$(df -h /home | tail -1 | awk '{print $2}')
used_space=$(df -h /home | tail -1 | awk '{print $3}')
avail_space=$(df -h /home | tail -1 | awk '{print $4}')
usage_percent=$(df -h /home | tail -1 | awk '{print $5}')

echo -e "\nDisk space summary for /home:" >> "$report_file"
echo "Total: $total_space" >> "$report_file"
echo "Used: $used_space ($usage_percent)" >> "$report_file"
echo "Available: $avail_space" >> "$report_file"
echo -e "\nUser disk usage breakdown:" >> "$report_file"

# Calculate and store user disk usage
declare -A user_usage_bytes
total_user_space=0

for user_dir in /home/*; do
    if [ -d "$user_dir" ]; then
        user=$(basename "$user_dir")
        # Get usage in bytes for calculation
        usage_bytes=$(du -s "$user_dir" 2>/dev/null | cut -f1)
        user_usage_bytes["$user"]=$usage_bytes
        total_user_space=$((total_user_space + usage_bytes))

        # Get human-readable size for display
        usage_human=$(du -sh "$user_dir" 2>/dev/null | cut -f1)

        # Convert to GB for threshold check (roughly)
        if [[ "$usage_human" == *G* ]]; then
            usage_gb=$(echo "$usage_human" | sed 's/G//')
            if (( $(echo "$usage_gb > $threshold_gb" | bc -l) )); then
                echo "$user: $usage_human [EXCEEDS THRESHOLD]" >> "$report_file"
            else
                echo "$user: $usage_human" >> "$report_file"
            fi
        else
            echo "$user: $usage_human" >> "$report_file"
        fi
    fi
done

# Calculate percentages
echo -e "\nPercentage of space used by each user:" >> "$report_file"
for user in "${!user_usage_bytes[@]}"; do
    if [ $total_user_space -gt 0 ]; then
        percentage=$(awk "BEGIN {printf \"%.2f\", ${user_usage_bytes[$user]}*100/$total_user_space}")
        echo "$user: $percentage%" >> "$report_file"
    fi
done

# Sort by size and show top 5 users
echo -e "\nTop 5 users by disk usage:" >> "$report_file"
du -sh /home/* 2>/dev/null | sort -hr | head -n 5 >> "$report_file"

echo "Report generated at $report_file"
```

### Additional Practice Exercise: Comprehensive System Report

This exercise combines many Linux commands and scripting techniques:

```bash
#!/bin/bash
# system_report.sh - Generate a comprehensive system report

# Output file
report="system_report_$(hostname)_$(date +%Y%m%d).txt"

# Function to add a section header
section() {
    echo -e "\n=== $1 ===" >> "$report"
}

echo "Generating system report..."
echo "System Report - $(hostname)" > "$report"
echo "Generated on: $(date)" >> "$report"
echo "----------------------------------------" >> "$report"

# System information
section "SYSTEM INFORMATION"
echo "Hostname: $(hostname)" >> "$report"
echo "Kernel: $(uname -r)" >> "$report"
echo "Uptime: $(uptime)" >> "$report"
echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')" >> "$report"

# CPU information
section "CPU INFORMATION"
lscpu | grep -E 'Model name|CPU\(s\)|Thread|Core' >> "$report"

# Memory usage
section "MEMORY USAGE"
free -h >> "$report"

# Disk usage
section "DISK USAGE"
df -h >> "$report"

# Top processes by CPU
section "TOP PROCESSES BY CPU"
ps aux --sort=-%cpu | head -11 >> "$report"

# Top processes by memory
section "TOP PROCESSES BY MEMORY"
ps aux --sort=-%mem | head -11 >> "$report"

# Recent logins
section "RECENT LOGINS"
last | head -10 >> "$report"

# Network interfaces
section "NETWORK INTERFACES"
ip addr | grep -E 'inet |^[0-9]+:' >> "$report"

# Open ports
section "OPEN PORTS"
if command -v ss &> /dev/null; then
    ss -tuln >> "$report"
elif command -v netstat &> /dev/null; then
    netstat -tuln >> "$report"
else
    echo "No tool available to list open ports" >> "$report"
fi

# Recent errors in logs
section "RECENT SYSTEM ERRORS"
grep -i error /var/log/syslog 2>/dev/null | tail -20 >> "$report"
grep -i error /var/log/messages 2>/dev/null | tail -20 >> "$report"

echo "Report completed! Saved to $report"
```

This comprehensive script demonstrates how many of the concepts from the questions can be combined to create a useful DevOps tool.

### Assignment

#### Question 1: Log File Analyzer

Create a bash script that analyzes a log file for errors and warnings. The script should:

Take a log file path as an argument
Count the number of ERROR, WARNING, and INFO messages
Display the 5 most common error messages with their occurrence count
Generate a summary report with timestamps of the first and last errors

##### Example Output

```bash
$ ./log_analyzer.sh /var/log/application.log

===== LOG FILE ANALYSIS REPORT =====
File: /var/log/application.log
Analyzed on: Fri Jul 12 14:32:15 EDT 2025
Size: 15.4MB (16,128,547 bytes)

MESSAGE COUNTS:
ERROR: 328 messages
WARNING: 1,253 messages
INFO: 8,792 messages

TOP 5 ERROR MESSAGES:
 182 - Database connection failed: timeout
  56 - Invalid authentication token provided
  43 - Failed to write to disk: Permission denied
  29 - API rate limit exceeded
  18 - Uncaught exception: Null pointer reference

ERROR TIMELINE:
First error: [2025-07-10 02:14:32] Database connection failed: timeout
Last error:  [2025-07-12 14:03:27] Failed to write to disk: Permission denied

Error frequency by hour:
00-04: ███████ (72)
04-08: ██ (23)
08-12: ████████████ (120)
12-16: ██████ (63)
16-20: ███ (34)
20-24: ████ (16)

Report saved to: log_analysis_20250712_143215.txt
```

#### Question 2 : System Health Monitor Dashboard

Create an interactive bash script that provides a real-time system health monitoring dashboard in the terminal. The script should:

- Display system metrics (CPU, memory, disk, network) that refresh every 3 seconds
- Use ASCII/ANSI characters to create visual graphs or bars representing usage percentages
- Include color coding (green/yellow/red) to indicate normal/warning/critical status levels
- Log any detected anomalies (spike in CPU, memory pressure, disk filling up) to a separate file
- Provide keyboard shortcuts to perform basic actions (change refresh rate, filter information, exit)

```bash
╔════════════ SYSTEM HEALTH MONITOR v1.0 ════════════╗  [R]efresh rate: 3s
║ Hostname: webserver-prod1          Date: 2025-07-12 ║  [F]ilter: All
║ Uptime: 43 days, 7 hours, 13 minutes               ║  [Q]uit
╚═══════════════════════════════════════════════════════════════════════╝

CPU USAGE: 67% ██████████████████████████████░░░░░░░░░░░░░ [WARNING]
  Process: mongod (22%), nginx (18%), node (15%)

MEMORY: 5.8GB/8GB (73%) █████████████████████████████░░░░░ [WARNING]
  Free: 2.2GB | Cache: 2.7GB | Buffers: 0.5GB

DISK USAGE:
  /        : 76% ███████████████████████████████░░░░ [WARNING]
  /var/log : 42% █████████████████░░░░░░░░░░░░░░░░░░ [OK]
  /home    : 28% ███████████░░░░░░░░░░░░░░░░░░░░░░░░ [OK]

NETWORK:
  eth0 (in) : 18.2 MB/s ███████░░░░░░░░░░░░░░░░░░░░░ [OK]
  eth0 (out): 4.5 MB/s  ██░░░░░░░░░░░░░░░░░░░░░░░░░░ [OK]

LOAD AVERAGE: 2.34, 2.15, 1.98

RECENT ALERTS:
[14:25:12] CPU usage exceeded 80% (83%)
[14:02:37] Memory usage exceeded 75% (78%)
[13:46:15] Disk usage on / exceeded 75% (76%)

Press 'h' for help, 'q' to quit
```
