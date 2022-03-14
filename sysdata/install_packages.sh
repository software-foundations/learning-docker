# -> pull ubuntu image
# https://hub.docker.com/r/jrei/systemd-ubuntu
sudo docker pull ubuntu:18.04

# -> create/run container
sudo docker container run --name smartvale -p 8080:8080 -it ubuntu:18.04 bash
exit

# -> start container
sudo docker container start -ai smartvale

# update
sudo apt update

# curl
sudo apt install curl

# -> install nano
apt install nano

# -> install micro
# https://www.geeksforgeeks.org/micro-lightweight-terminal-based-text-editor/

curl https://getmic.ro | bash
sudo mv micro /usr/bin/


# -> install tomcat 8.5.39
# https://linuxize.com/post/how-to-install-tomcat-8-5-on-ubuntu-18-04/
# wget from https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.39/bin/apache-tomcat-8.5.39.zip instead of the tutorial link


[Unit]
Description=Tomcat 8.5 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/default-java"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"

Environment="CATALINA_BASE=/opt/tomcat/apache-tomcat-8.5.39"
Environment="CATALINA_HOME=/opt/tomcat/apache-tomcat-8.5.39"
Environment="CATALINA_PID=/opt/tomcat/apache-tomcat-8.5.39/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/apache-tomcat-8.5.39/bin/startup.sh
ExecStop=/opt/tomcat/apache-tomcat-8.5.39/bin/shutdown.sh

[Install]
WantedBy=multi-user.target

# -> add user
# https://www.vivaolinux.com.br/etc/tomcatusers.xml
micro /opt/tomcat/apache-tomcat-8.5.39/conf/tomcat-users.xml

    
    <?xml version='1.0' encoding='utf-8'?>
    <tomcat-users>
    <role rolename="manager"/>
    <role rolename="admin"/>
    <role rolename="manager-gui"/>
    <user username="admin" password="admin" roles="admin,manager,manager-gui"/>
    </tomcat-users>


# -> edit context.xml file
# http://www.freekb.net/Article?id=1378#:~:text=Tomcat%20%2D%20Resolve%20%22403%20Access%20Denied%22&text=This%20error%20appears%20when%20attempting,to%20%22edit%20the%20Manager's%20context.


# https://linuxhint.com/start-stop-apache-tomcat/
cd /opt/tomcat/apache-tomcat-8.5.39/bin
./startup


# -> Execute
# sudo docker container exec <conainer_name> <shell_command>
sudo docker container start
sudo docker container exec smartvale /opt/tomcat/apache-tomcat-8.5.39/bin/./startup.sh