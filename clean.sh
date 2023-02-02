#/bin/bash

sudo rm -rf data moodle
sudo docker system prune -af --volumes
