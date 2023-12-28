FROM moussavdb/build-java:21 as build
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
RUN git clone --single-branch -b develop https://$GITHUB_TOKEN@github.com/yildiz-online/retro-player.git
WORKDIR /retro-player
RUN mvn clean package -Pbuild-assembly -Pjavafx
