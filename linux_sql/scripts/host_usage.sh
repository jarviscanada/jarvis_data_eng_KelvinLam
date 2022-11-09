date_out=`date '+%Y-%m-%d %H:%M:%S'`
meminfo_out=`cat /proc/meminfo`
vmstat_out=`vmstat --unit M`
vmstat_disk_out=`vmstat -d`
df_out=`df -BM /`

#usage info
timestamp=$(echo "$date_out")
memory_free=$(echo "$meminfo_out" | egrep "MemFree:" | awk '{print substr($2, 1, length($2)-3)}' | xargs)
cpu_idle=$(echo "$vmstat_out" | tail -1 | awk '{print $15}' | xargs)
cpu_kernel=$(echo "$vmstat_out" | tail -1 |  awk '{print $14}' | xargs)
disk_io=$(echo "$vmstat_disk_out" | tail -1 | awk '{print $10}' | xargs)
disk_available=$(echo "$df_out" | tail -1 | awk '{print substr($4, 1, length($4)-1)}' | xargs)

echo "timestamp=$timestamp
memory_free=$memory_free
cpu_idle=$cpu_idle
cpu_kernel=$cpu_kernel
disk_io=$disk_io
disk_available=$disk_available"
