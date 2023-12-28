FROM alpine/git as clone
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
ARG GH_TOKEN
WORKDIR /app
RUN echo $test
RUN git clone https://$GH_TOKEN@github.com/yildiz-online/retro-player.git


