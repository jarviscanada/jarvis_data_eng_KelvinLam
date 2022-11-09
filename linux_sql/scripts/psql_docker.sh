#! /bin/bash

#Setup arguments
action=$1
db_username=$2
db_password=$3

# Check status of docker server and start docker server if it is not running
sudo systemctl status docker || sudo systemctl start docker

# Check container status
docker container inspect jrvs-psql
container_status=$?

# Switch for different case of $action
case $action in
  # Create handler
  create)
    # Check if the container already exists; exit 1 if exists
    if [ $container_status -eq 0 ]; then
      echo 'Container already exists'
      exit 1
    fi

    # Check number of arguments; exit 1 if not equals to 3
    if [ $# -ne 3 ]; then
      echo 'Create requires username and password'
      exit 1
    fi

    # Create volume; volume name: pgdata
    docker volume create pgdata

    # Create container; container name: jrvs-psql
    #                   environment variable POSTGRES_PASSWORD: $db_password
    #                   detached mode,
    #                   volume name: pgdata
    #                   mounted path: /var/lib/postgresql/data
    #                   published port: hostPort(5432) to containerPort(5432)
    #                   image: postgres: 9.6-alpine
    docker run --name jrvs-psql -e POSTGRES_PASSWORD="$db_password" -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres:9.6-alpine
    exit $?
    ;;

  # Start | stop handler
  start | stop)
    # Check if the container is not created; exit 1 if container is not created
    if [ $container_status -eq 1 ]; then
      echo 'Container is not created'
      exit 1
    fi

    # Start / stop the container
    docker container "$action" jrvs-psql
    exit $?
    ;;

  # else handler
  *)
    echo 'Illegal command'
    echo 'Commands: start|stop|create'
    exit 1
    ;;
esac

exit 0