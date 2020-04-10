#!/bin/bash

set -m

# Start the first process
/usr/bin/tensorboard --bind_all --logdir /tmp/ &

# Start the second process
/usr/bin/jupyter lab --no-browser --ip=0.0.0.0 --port=6007 --allow-root 

