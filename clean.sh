#/bin/bash

sudo rm -rf data moodledata 
sudo docker system prune -af --volumes
