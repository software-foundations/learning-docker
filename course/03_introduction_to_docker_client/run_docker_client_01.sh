# -> Show docker commands
docker

# -> Test the hello world image
docker container run hello-world

#############
# Run command
# Always create new containbers

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

# -> Different modes on docker

# 1. Daemon: Execute the container in background
# 2. Interative: To test, set and explore containers

#####################
# -> Interactive mode
#####################

# -> Run a container in (i)terative mode in (t)erminal, entering in the container terminal
sudo docker container run -it debian bash

# Doing things in container terminal
touch docker-course.txt
ls docker-course.txt
ls

# Going out the container
exit

# Create the container again and check the docker-course.txt file
# is not there anymore, because it is a new container
sudo docker container run -it debian bash
ls docker-course.txt

	# ls: cannot access 'docker-course.txt': No such file or directory


exit

# Observe Container Names given by docker
sudo docker container ps -a

##########################
# Create a named container
##########################
sudo docker container run --name <name> -<mode> <image> <command>
sudo docker container run --name mydeb -it debian bash
exit

#  Trying creating a named contair which name already exists
# sudo docker container run --name mydeb -it debian bash

# 	docker: Error response from daemon: Conflict. The container name "/mydeb" is already in use by container "342e771885410fce71b732c4cc17d9ad106cc31c65628b43a49bd89fbd6e3a27". You have to remove (or rename) that container to be able to reuse that name.
# See 'docker run --help'.

##################
# Reuse containers
##################

# -> Showing containers wherever their status are
sudo docker container ps -a

# -> Start an existing container in interactive mode
# sudo docker container start -ai <container_name> (equivalent to sudo docker container run -it <container_name>, but it creates the container itself, not only starts it)
sudo docker container start -ai mydeb

# Creating files in the started container
touch docker-course.txt
ls
exit

# -> Start an existing container in interactive mode again to check if the docker-course.txt file is there
# sudo docker container start -ai <container_name> (equivalent to sudo docker container run -it <container_name>, but it creates the container itself, not only starts it)
sudo docker container start -ai mydeb
ls
exit

#########################
# Mapping container ports
#########################

# -> Expose a container by a port
sudo docker container run -p <exposed_port>:<internal_port> <image_name>
sudo docker container run -p 8080:80 nginx

# -> Test comunication with nginx container by http protocol

# 1. In other terminal, test the nginx container port communication
curl http://localhost:8080
curl http://127.0.0.1:8080

	<!DOCTYPE html>
	<html>
	<head>
	<title>Welcome to nginx!</title>
	<style>
	    body {
	        width: 35em;
	        margin: 0 auto;
	        font-family: Tahoma, Verdana, Arial, sans-serif;
	    }
	</style>
	</head>
	<body>
	<h1>Welcome to nginx!</h1>
	<p>If you see this page, the nginx web server is successfully installed and
	working. Further configuration is required.</p>

	<p>For online documentation and support please refer to
	<a href="http://nginx.org/">nginx.org</a>.<br/>
	Commercial support is available at
	<a href="http://nginx.com/">nginx.com</a>.</p>

	<p><em>Thank you for using nginx.</em></p>
	</body>
	</html>


# 2. Test http://127.0.0.1:8080 on browser

# -> Check active container process
sudo docker container ps


##################################
# Maping directories to containers
##################################


# -> 1. Create a folder
mkdir 01_docker-course

# -> 2. Create a folder to be mapping as a volume
cd 01_docker-course
mkdir 01_example-volume

# -> 3. Run a docker container, and mapping a volumn using the -v flag
sudo docker container run -p <host_port>:<container_port> -v <abs_path_host_folder>:<abs_path_container_folder> <image>

# In this case, the container will point to host_folder every time the container folder
# is called by port 8080

# In other words, the os port 8080 points to 80 at the container
# while the container folder points to host folder

# Terminal 01
cd 01_example-volume
sudo docker container run -p 8080:80 -v $(pwd)/not-found:/usr/share/nginx/html nginx

# -> 4. Test the conection

# Terminal 02
curl http://127.0.0.1:8080

	<html>                                                         
	<head><title>403 Forbidden</title></head>                    
	<body>                                                                              
	<center><h1>403 Forbidden</h1></center>                                                                                                                              
	<hr><center>nginx/1.19.10</center>
	</body>                                  
	</html>


# Or open http://127.0.0.1:8080 in browser
<html>                                                         
<head><title>403 Forbidden</title></head>                    
<body>                                                                              
<center><h1>403 Forbidden</h1></center>                                                                                                                              
<hr><center>nginx/1.19.10</center>
</body>                                  
</html>

# -> 5. Create html folder inside 01_example-volume; index.html inside html folder
mkdir html
cd html
touch index.html

# -> 6. writes in index.html
<html>
	<head>
		<title>Docker Course</title>
	</head>
	<body>
		<h1>Docker Course</h1>
	</body>
</html>

# -> 7. Making nginx points to index.html we create at the host folder

# Inside 01_example-volume ...
sudo docker container run -p <host_port>:<container_port> -v <abs_path_host_folder>:<abs_path_container_folder> <image>

sudo docker container run -p 8080:80 -v $(pwd)/html:/usr/share/nginx/html nginx


# -> 8. Test the conection

Terminal 02
curl http://127.0.0.1:8080

	<html>                            
	        <head>                           
	                <title>Docker Course</title>
	        </head>                              
	        <body>                    
	                <h1>Docker Course</h1>
	        </body>
	</html>

# Or open http://127.0.0.1:8080 in browser
<html>                            
        <head>                           
                <title>Docker Course</title>
        </head>                              
        <body>                    
                <h1>Docker Course</h1>
        </body>
</html>

##################################################################
# Execute a web server (container) in background: -d flag (daemon)
##################################################################

sudo docker container run -d --name <container_name> -p <host_port>:<container_port> -v <abs_path_host_folder>:<abs_path_container_folder> <image>

# -> 1. Create a folder and enter in it and copy html/index.html content from ../01_example-volume

mkdir 02_example-volume
cd 02_example-volume
mkdir html
cp ../01_example-volume/html/index.html html/

# -> 2. Execute a web server in background. The hash code is the container id being executed in background (daemon mode)

$ sudo docker container run -d --name 02_example-daemon-basic -p 8080:80 -v $(pwd)/html:/usr/share/nginx/html nginx

	a06f96b64168236e10dd7dfb0c4ba9470b3eeb1079b633d26d887e2687482c7d 

$

# -> 3. See active container process
sudo docker container ps

	CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                   
	NAMES
	a06f96b64168   nginx     "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:8080->80/tcp, :::8080->80/tcp   
	01_example-daemon-basic

# -> 4. Test the conection

# Terminal 02
curl http://0.0.0.0:8080

	<html>                            
	        <head>                           
	                <title>Docker Course</title>
	        </head>                              
	        <body>                    
	                <h1>Docker Course</h1>
	        </body>
	</html>

# Or open http://127.0.0.1:8080 in browser
<html>                            
        <head>                           
                <title>Docker Course</title>
        </head>                              
        <body>                    
                <h1>Docker Course</h1>
        </body>
</html>

# -> 5. Stop the daemon (container process in background)
sudo docker container stop 02_example-daemon-basic

#############################
# Manage docker in background

# docker container start <container name or id>
# docker container restart <container name or id>
# docker container stop <container_name or id>
#############################

cd 01_docker-course/02_example-volume

sudo docker container start 02_example-daemon-basic

sudo docker container ps

sudo docker container restart 02_example-daemon-basic

sudo docker container stop 02_example-daemon-basic
