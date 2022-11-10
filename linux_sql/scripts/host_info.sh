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
lscpu_out=$(lscpu)
meminfo_out=$(cat /proc/meminfo)

# Hardware info
hostname=$(hostname -f)
cpu_number=$(echo "$lscpu_out"  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(echo "$lscpu_out" | egrep "^Architecture:" | awk '{print $2}' | xargs)
cpu_model=$(echo "$lscpu_out" | egrep "^Model name:" | awk -F ':' '{print $2}' | xargs)
cpu_mhz=$(echo "$lscpu_out" | egrep "^CPU MHz:" | awk -F ':' '{print $2}' | xargs)
l2_cache=$(echo "$lscpu_out" | egrep "^L2 cache:" | awk -F ':' '{print substr($2, 1, length($2)-1)}' | xargs)
total_mem=$(echo "$meminfo_out" | egrep "^MemTotal:" | awk '{print $2}' | xargs)
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Build insert_statement
insert_statement="INSERT INTO host_info (hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, L2_cache, total_mem, timestamp) VALUES ('$hostname', $cpu_number, '$cpu_architecture', '$cpu_model', $cpu_mhz, $l2_cache, $total_mem, '$timestamp');"

# Execute insert_statement
export PGPASSWORD=$psql_password
psql -h "$psql_host" -p $psql_port -d "$db_name" -U "$psql_user" -c "$insert_statement"

exit $?