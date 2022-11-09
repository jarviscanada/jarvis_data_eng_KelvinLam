lscpu_out=`lscpu`
meminfo_out=`cat /proc/meminfo`
date_out=`date '+%Y-%m-%d %H:%M:%S'`

#hardware info
hostname=$(hostname -f)
cpu_number=$(echo "$lscpu_out"  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(echo "$lscpu_out" | egrep "^Architecture:" | awk '{print $2}' | xargs)
cpu_model=$(echo "$lscpu_out" | egrep "^Model name:" | awk -F ':' '{print $2}' | xargs)
cpu_mhz=$(echo "$lscpu_out" | egrep "^CPU MHz:" | awk -F ':' '{print $2}' | xargs)
l2_cache=$(echo "$lscpu_out" | egrep "^L2 cache:" | awk -F ':' '{print substr($2, 1, length($2)-1)}' | xargs)
total_mem=$(echo "$meminfo_out" | egrep "^MemTotal:" | awk '{print $2}' | xargs)
timestamp=$(echo "$date_out")

echo "hostname=$hostname
cpu_number=$cpu_number
cpu_architecture=$cpu_architecture
cpu_model=$cpu_model
cpu_mhz=$cpu_mhz
L2_cache=$l2_cache
total_mem=$total_mem
timestamp=$timestamp"
