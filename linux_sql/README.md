# Linux Cluster Monitoring Agent
This project is under development. Since this project follows the GitFlow, the final work will be merged to the main branch after Team Code Team.

## Introduction
The Jarvis Linux Cluster Administration (LCA) team manages a Linux cluster of 10 nodes/servers running CentOS 7. These servers are internally connected through a switch and able to communicate through internal IPv4 addresses.

The LCA team needs to record the hardware specifications of each node and monitor node resource usage (e.g. CPU, memory) in real-time and stored in an RDBMS.

The LCA team will use the data to generate reports for future resource planning purposes (e.g. add or remove servers).

## Quick Start
### Command to create / start / stop PostgreSQL container

```
// General form
$ ./scripts/psql_docker.sh start|stop|create [db_username][db_password]

// To create and start PostgreSQL container
$ ./scripts/psql_docker.sh create <db_username> <db_password>

// To start PostgreSQL container
$ ./scripts/psql_docker.sh start

// To stop PostgreSQL container
$ ./scripts/psql_docker.sh stop
```

### Before connect to the psql instance
```
$ export PGPASSWORD=<db_password>
```

### Command to connect to the psql instance
```
// General form
$ psql -h [hostname] -U <db_username> -d [db_name]

// Example
$ psql -h localhost -U root -d host_agent
```

### `ddl.sql` statement
```
// General form
$ psql -h [hostname] -U [db_username] -d [db_name] -f sql/ddl.sql

// Example
$ psql -h localhost -U root -d host_agent -f sql/ddl.sql
```

### `host_info.sh` script
```
// General form
$ ./scripts/host_info.sh [psql_host] [psql_port] [db_name] [psql_user] [psql_password]

// Example
$ ./scripts/host_info.sh localhost 5432 host_agent root pass
```

### `host_usage.sh` script
```
// General form
$ ./scripts/host_usage.sh [psql_host] [psql_port] [db_name] [psql_user] [psql_password]

// Example
$ ./scripts/host_usage.sh localhost 5432 host_agent root pass
```

### To run `host_usage.sh` script every minute
```
// Edit crontab file
$ crontab -e

// Set to run `host_usage.sh` every minute
* * * * * bash /home/centos/dev/jrvs/bootcamp/linux_sql/host_agent/scripts/host_usage.sh localhost 5432 host_agent postgres password > /tmp/host_usage.log

// List crontab jobs
$ crontab -l
```

## Implemenation

### Architecture
![alt text](./assets/architecture.png)

### Scripts


### Database Modeling

## Test

## Deployment

## Improvements