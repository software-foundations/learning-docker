# Show docker commands

```console
docker
```

# Test the hello world image

```console
sudo docker container run hello-world
```

# Run command
---
Always create new containers

- Concatenate 4 commands:
1. Docker image pull (Download image from Registry)
2. Docker container create (Create the container)
3. Docker container start (Initializate the container)
4. Docker container exec (Execute the container in iterative mode)

# Different modes on docker

1. Daemon: Execute the container in background
2. Interative: To test, set and explore containers

## Interative

- Check active containers
```console
sudo docker container ps
```

- Check all executed containers, even they are not actived
```console
sudo docker container ps -a
```

- Run a container and remove it after its execution
```console
sudo docker container run --rm debian
sudo docker container run --rm debian bash --version
```

- Run a container in (i)terative mode in (t)erminal, entering in the container terminal
```console
sudo docker container run -it debian bash
```

Doing things in container terminal
```console
touch docker-course.txt
ls docker-course.txt
ls
```

Going out the container
```console
exit
```

Create the container again and check the docker-course.txt file
is not there anymore, because it is a new container
```console
sudo docker container run -it debian bash
ls docker-course.txt

	ls: cannot access 'docker-course.txt': No such file or directory


exit
```

Observe Container Names given by docker
```console
sudo docker container ps -a
```

# Naming containers

- Help run command
```console
sudo docker container run --help
```

- Create a named container
sudo docker container run --name <name> -<mode> <image> <command>
```console
sudo docker container run --name mydeb -it debian bash
exit
```

- Trying creating a named contair which name already exists
```console
sudo docker container run --name mydeb -it debian bash

	docker: Error response from daemon: Conflict. The container name "/mydeb" is already in use by container "342e771885410fce71b732c4cc17d9ad106cc31c65628b43a49bd89fbd6e3a27". You have to remove (or rename) that container to be able to reuse that name.
See 'docker run --help'.

```

# Reuse containers

- Showing containers wherever their status are
```console
sudo docker container ps -a
```

- Start an existing container in interactive mode
sudo docker container start -ai <container_name> (equivalent to sudo docker container run -it <container_name>, but it creates the container itself, not only starts it)
```console
sudo docker container start -ai mydeb
```

Creating files in the started container
```console
touch docker-course.txt
ls
exit
```

- Start an existing container in interactive mode again to check if the docker-course.txt file is there
sudo docker container start -ai <container_name> (equivalent to sudo docker container run -it <container_name>, but it creates the container itself, not only starts it)
```console
sudo docker container start -ai mydeb
ls
exit
```

# Maping container ports

- Expose a container by a port
sudo docker container run -p <exposed_port>:<internal_port> <image_name>
```console
sudo docker container run -p 8080:80 nginx
```
- Test comunication with nginx container by http protocol

1. In other terminal, test the nginx container port communication
```console
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
```

2. Test http://127.0.0.1:8080 on browser

- Check active container process
```console
sudo docker container ps
```

# Maping directories to containers

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
```

Or open http://127.0.0.1:8080 in browser
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
