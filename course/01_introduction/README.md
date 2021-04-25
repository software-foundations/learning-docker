# Docker is ...

- Virtualization Tecnology based on Software
- Container Administration Engine
- Based on LXC (Linux Containers)
- Written in Go

# Docker is not ...

- A virtual machine


# Docker ...

- Packs software in different levels of isolation
- Allows access containers from ip address

# In docker ...

- Host and Container Shares the kernel
- Container is a process in Host OS
- Container processes cannot access nothing outside in container

# Why not Virtual Machine?

- Container consumes less resources

# Container (is) ...

- Segregate process at the same kernel
- Is a isolated process which can have subprocesses
- System File created from an Docker Image
- Ligh and portable environment in which appications can be executed
- Encapsulate all bins and libs necessaries for the execution of the application
- Something between a chroot and a Virtual Machine

### chroot is...

- a command which change the root folder of the File System

# Docker Image(s) ...

- Is a model of File System ready-only used to create containers
- Create a layer when it startsup, and only this layer can be modified

- Shouldn't be created by commit command
- Should be created by a process called build (mantain trail)
- Are storaged in the repositories on Registry (Docker Hub)
- Are compound by one or more layers

# Docker Image Layers(s) ...

- Represents one or more changes in File Systems
- Sometimes called intermediate Layers
- When compound form the Docker Image

# Docker Images and Layers ...

- Allows reuse
- Allows compound images from other image Layers

# Images vs Containers

- Images are like classes
- Containers are like objects

# Arquitecture

- Client: access the daemon via some interface
- Host: daemon downloads from images from Resgistry
- Host: Creates new images
- Host: Startsup container by images

## Client
- Cli
- Rest API
- Kitematic

## Host
- Deamon
- Images
- Containers

## Registry (Docker Hub)
- Images
