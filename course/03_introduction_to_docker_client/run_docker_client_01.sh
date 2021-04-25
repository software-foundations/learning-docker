# -> Show docker commands
docker

# -> Test the hello world image
docker container run hello-world

#############
# Run command
# - Concatenate 4 commands:
# 1. Docker image pull (Download image from Registry)
# 2. Docker container create (Create the container)
# 3. Docker container start (Initializate the container)
# 4. Docker container exec (Execute the container in iterative mode)
#############

###########################
# Different modes on docker

# 1. Daemon: Execute the container in background
# 2. Interative: To test, set and explore containers
###########################

# -> check the bash version
bash --version

# -> Download debian image and check its bash version
# just to check if the bash versions matches
# just to see that the container run its own bash,
# and not the OS bash, but both share OS kernel
sudo docker container run debian bash --version

# -> check active containers
sudo docker container ps

# -> check all containers
sudo docker container ps -a

# -> run a container and remove it after its execution
sudo docker container run --rm debian
sudo docker container run --rm debian bash --version
