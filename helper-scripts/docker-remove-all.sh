
# hpefully remove everything

# stop all running containers
sudo docker stop $(docker ps -aq)

# remove all conatiners
sudo docker rm -f $(docker ps -aq)
sudo docker container prune -f


# remove all images
sudo docker rmi $(docker images -qa)
sudo docker image prune -a -f

# delete all volumes
sudo docker volume rm $(docker volume ls -q)
sudo docker volume prune -f
sudo docker system prune --volumes -f

sudo docker network prune -f


# just in case
# the problem with this by itself is that it respect resorces linked to running or existing containers

sudo docker system prune -a -f
