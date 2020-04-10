#!/bin/bash

docker run -d -p 6006:6006 -p 6007:6007 leap15.2/tfx > ID

ID=`cat ID`

echo "Container ID is $ID"

echo "Waiting to retrieve JupyterLab URL with TOKEN"
sleep 15;

docker exec -it $ID sh -c "/usr/bin/jupyter notebook list"

