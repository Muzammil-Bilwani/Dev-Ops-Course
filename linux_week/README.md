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
