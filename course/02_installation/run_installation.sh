# https://docs.docker.com/engine/install/ubuntu/


# 01 -> Update the apt package index
sudo apt-get update

# 02 -> Install packages to allow apt to use a repository pver HTTPS
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

# 03 -> Add Docker's official GPG Key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 04 -> Set up the stabel repository
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 05 -> Install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# 05 -> Install a specific version of Docker Engine

# List versions
apt-cache madison docker-ce

# install
sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io

# 06 -> Verify that Docker Engine is installed correctly by running the hello-world image
sudo docker run hello-world