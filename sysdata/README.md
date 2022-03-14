# SETUP ENVIRONMENT

# Basic usage

- Download ubuntu:18.04 image from registry (docker hub)

```console
docker pull ubuntu:18.04
```

- Check bash ubuntu:18.04 bash version

```console
sudo docker run ubuntu:18.04 bash --version
```

- Check container beeing executed

```console
sudo docker container ps
```

- Check all executed containers, even they are not actived

```console
sudo docker container ps -a
```

- Run a container and remove it after its execution

```console
sudo docker container run --rm ubuntu:18.04
sudo docker container run --rm ubuntu:18.04 bash --version
```

- Run a container in (i)terative mode in (t)erminal, entering in the container terminal
```console
sudo docker container run -it ubuntu:18.04 bash
```

Doing things in container terminal
```console
touch test.txt
ls test.txt
ls
```

Going out the container
```console
exit
```

Create the container again and check the docker-course.txt file
is not there anymore, because it is a new container
```console
sudo docker container run -it ubuntu:18.04 bash
ls docker-course.txt

	ls: cannot access 'docker-course.txt': No such file or directory


exit
```

Observe Container Names given by docker
```console
sudo docker container ps -a
```

- Help run command

```console
sudo docker container run --help
```

## Naming containers

- Create a named container
- Raises error when trying creating an existing named container

sudo docker container run --name <name> -<mode> <image> <command>
```console
sudo docker container run --name smartvale -it ubuntu:18.04 bash
exit
```

## Renaming Containers

- List containers
```console
sudo docker container ls
```

- List containers, even  if they aren't running
```console
sudo docker container ls -a
```

- (a)ttach (i)nterative
- -ai is equivalent of -it
sudo docker container start -ai <container_name>
```console
sudo docker container start -ai smartvale
```

- Create a file, exit the container
```console
touch test.txt
exit
```
- Enter in smartvale container
- Check if the test.txt exists
```console
sudo docker container start -ai smartvale
ls test.txt
```

## Maping Container ports

- mapping

sudo docker container run -p <exposed_port>:<internal_port> <image_name>

- Example with ngninx
```console
sudo docker container run -p 8080:80 nginx
```

- In other terminal, make a http request
```console
curl http://127.0.0.1:8080
```

- Check actived containers
```console
sudo docker container ps
```

- Exit nginx container
```console
exit
```

## Mapping directories to containers

1. Create a folder
```console
mkdir 01_docker-course
```

2. Create a folder to be mapping as a volume
```console
cd 01_docker-course
mkdir 01_example-volume
```

3. Run a docker container, and mapping a volumn using the -v flag
sudo docker container run -p <host_port>:<container_port> -v <abs_path_host_folder>:<abs_path_container_folder> <image>

In this case, the container will point to host_folder every time the container folder
is called by port 8080

In other words, the os port 8080 points to 80 at the container
while the container folder points to host folder

Terminal 01
```console
cd 01_example-volume
sudo docker container run -p 8080:80 -v $(pwd)/not-found:/usr/share/nginx/html nginx
```

4. Test the conection

Terminal 02
```console
curl http://127.0.0.1:8080

	<html>                                                         
	<head><title>403 Forbidden</title></head>                    
	<body>                                                                              
	<center><h1>403 Forbidden</h1></center>                                                                                                                              
	<hr><center>nginx/1.19.10</center>
	</body>                                  
	</html>
```

Or open http://127.0.0.1:8080 in browser
```html
<html>                                                         
<head><title>403 Forbidden</title></head>                    
<body>                                                                              
<center><h1>403 Forbidden</h1></center>                                                                                                                              
<hr><center>nginx/1.19.10</center>
</body>                                  
</html>
```

5. Create html folder inside 01_example-volume; index.html inside html folder
```console
mkdir html
cd html
touch index.html
```

6. writes in index.html
```html
<html>
	<head>
		<title>Docker Course</title>
	</head>
	<body>
		<h1>Docker Course</h1>
	</body>
</html>
```

7. Making nginx points to index.html we create at the host folder

Inside 01_example-volume ...

sudo docker container run -p <host_port>:<container_port> -v <abs_path_host_folder>:<abs_path_container_folder> <image>

```console
sudo docker container run -p 8080:80 -v $(pwd)/html:/usr/share/nginx/html nginx
```

8. Test the conection

Terminal 02
```console
curl http://127.0.0.1:8080

	<html>                            
	        <head>                           
	                <title>Docker Course</title>
	        </head>                              
	        <body>                    
	                <h1>Docker Course</h1>
	        </body>
	</html>

curl http://0.0.0.0:8080

	<html>                            
	        <head>                           
	                <title>Docker Course</title>
	        </head>                              
	        <body>                    
	                <h1>Docker Course</h1>
	        </body>
	</html>
```

Or open http://127.0.0.1:8080 in browser
Or open http://0.0.0.0:8080 in browser
```html
<html>                            
        <head>                           
                <title>Docker Course</title>
        </head>                              
        <body>                    
                <h1>Docker Course</h1>
        </body>
</html>
```

## Execute a web server (container) in background: -d flag (daemon)

sudo docker container run -d --name <container_name> -p <host_port>:<container_port> -v <abs_path_host_folder>:<abs_path_container_folder> <image>

## Manage containers running in background

sudo docker container start <container_name_or_ID>
```console
sudo docker container start smartvale
```

sudo docker container restart <container_name_or_ID>
```console
sudo docker container restart smartvale
```

sudo docker container stop <container_name_or_ID>
```console
sudo docker container stop smartvale
```

## Manage containers in daemon mode

- List active containers

```console
sudo docker container ps
sudo docker container ls
sudo docker container list
```

- List all containers (inactived included)

```console
sudo docker container ps -a
sudo docker container ls -a
sudo docker container list -a
```

- Access Container Logs

sudo docker container logs <container_name>
```console
sudo docker container start smartvale
sudo docker container logs smartvale
```

- Inspect a container

sudo docker container inspect <container_name>
```console
sudo docker container inspect smartvale
```

- Execute a shell command in a container

sudo docker container exec <conainer_name> <shell_command>
```console
sudo docker container exec smartvale uname -or
```

## New Syntax

```console
sudo docker container ls
sudo docker image ls
sudo docker volume ls
```

- Remove an image

```console
sudo docker image rm <image_name>
```

- Remove a container
```console
sudo docker container rm <container_name>
```
