# Test Data for System Health Monitor Dashboard

This directory contains generated test data files to help you develop and test
your system health monitoring dashboard without needing to read actual system metrics.

## How to Use

1. Run the `generate_system_data.sh` script in a separate terminal window:
   
   ```
   ./generate_system_data.sh
   ```

2. This will create a `test_data` directory with simulated system metrics

3. In your monitoring script, instead of reading from real system commands,
   read from these files:

   - `test_data/cpu` - Contains current CPU usage percentage
   - `test_data/memory` - Contains memory information in /proc/meminfo format
   - `test_data/disk` - Contains disk usage in df output format
   - `test_data/network` - Contains network interface information
   - `test_data/loadavg` - Contains load average values
   - `test_data/top_processes` - Contains info about top CPU-consuming processes
   - `test_data/alerts` - Contains recent system alerts

4. The data will update every 2 seconds to simulate changing system conditions

## Example

```bash
# Sample code to read CPU from test data instead of real system
read_cpu() {
  if [ -f "test_data/cpu" ]; then
    cat test_data/cpu
  else
    # Fall back to real system data if test file not available
    top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}'
  fi
}
```

This approach allows you to develop and test your dashboard with predictable data
before trying it on a real system.
