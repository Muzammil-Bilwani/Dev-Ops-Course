# Linux Assignment Resources

This directory contains resources for the Linux Scripting assignments.

## Contents

1. **Log Analyzer Assignment**

   - `sample_application.log` - Sample log file to test your log analyzer script
   - `log_analyzer_template.sh` - Starter template for the log analyzer script

2. **System Health Monitor Assignment**
   - `generate_system_data.sh` - Script to generate test data for the system monitor
   - `system_monitor_template.sh` - Starter template for the system monitor script
   - `system_monitor_README.txt` - Instructions for using the test data generator

## Usage Instructions

### For Log Analyzer:

1. Use the provided template as a starting point:

   ```bash
   cp log_analyzer_template.sh my_log_analyzer.sh
   chmod +x my_log_analyzer.sh
   ```

2. Edit the script to implement the required functionality

3. Test your script with the sample log file:
   ```bash
   ./my_log_analyzer.sh sample_application.log
   ```

### For System Health Monitor:

1. Use the provided template as a starting point:

   ```bash
   cp system_monitor_template.sh my_system_monitor.sh
   chmod +x my_system_monitor.sh
   ```

2. Run the data generator in a separate terminal:

   ```bash
   ./generate_system_data.sh
   ```

3. Edit the script to implement the required functionality

4. Run your system monitor script:
   ```bash
   ./my_system_monitor.sh
   ```

## Tips

- Read the template scripts carefully, they contain helpful comments and TODOs
- Use the provided sample data to test your scripts
- Don't forget to make your scripts executable using `chmod +x`
- Include proper error handling and input validation in your scripts
