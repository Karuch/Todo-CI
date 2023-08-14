#!/bin/sh

set -e
sleep 5
echo "start"
echo $RANDOM_CONTAINER_NAME
echo ${RANDOM_CONTAINER_NAME}
export RANDOM_CONTAINER_NAME=$RANDOM_CONTAINER_NAME
echo $RANDOM_CONTAINER_NAME
echo ${RANDOM_CONTAINER_NAME}
echo "end"

echo posting task...
curl -X POST tal-flask-$RANDOM_CONTAINER_NAME:5000/api/add -d "task=eat"
echo task posted
echo edit task...
curl -X PUT tal-flask-$RANDOM_CONTAINER_NAME:5000/api/edit -d "old_task=eat&new_task=walk"
echo task edited
echo getting tasks...
curl -X GET tal-flask-$RANDOM_CONTAINER_NAME:5000/api
echo got tasks
echo deleting task...
curl -X POST tal-flask-$RANDOM_CONTAINER_NAME:5000/api/delete -d "task=walk"
echo task deleted

