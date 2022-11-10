#!/bin/bash

# Check number of arguments; exit 1 if not equals to 5
if [ $# -ne 5 ]; then
  echo 'Requires <psql_host> <psql_port> <db_name> <psql_user> <psql_password>'
  exit 1
fi

# Setup arguments
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

# Data sources
meminfo_out=$(cat /proc/meminfo)
vmstat_out=$(vmstat --unit M)
vmstat_disk_out=$(vmstat -d)
df_out=$(df -BM /)

#usage info
hostname=$(hostname -f)
memory_free=$(echo "$meminfo_out" | egrep "MemFree:" | awk '{print substr($2, 1, length($2)-3)}' | xargs)
cpu_idle=$(echo "$vmstat_out" | tail -1 | awk '{print $15}' | xargs)
cpu_kernel=$(echo "$vmstat_out" | tail -1 |  awk '{print $14}' | xargs)
disk_io=$(echo "$vmstat_disk_out" | tail -1 | awk '{print $10}' | xargs)
disk_available=$(echo "$df_out" | tail -1 | awk '{print substr($4, 1, length($4)-1)}' | xargs)
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Build select_statement
select_statement="SELECT id FROM host_info WHERE hostname='$hostname'"

# Execute select_statement
export PGPASSWORD=$psql_password
host_id=$(psql -h "$psql_host" -p $psql_port -d "$db_name" -U "$psql_user" -t -c "$select_statement")

# Build insert_statement
insert_statement="INSERT INTO host_usage (host_id, memory_free, cpu_idle, cpu_kernel, disk_io, disk_available, timestamp) VALUES ($host_id, $memory_free, $cpu_idle, $cpu_kernel, $disk_io, $disk_available, '$timestamp');"

# Execute insert_statement
psql -h "$psql_host" -p $psql_port -d "$db_name" -U "$psql_user" -c "$insert_statement"

exit $?