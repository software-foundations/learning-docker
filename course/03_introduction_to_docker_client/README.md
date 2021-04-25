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
