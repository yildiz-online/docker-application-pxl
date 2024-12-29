FROM alpine/git as clone
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
ARG GH_TOKEN
WORKDIR /app
RUN git clone -b master https://$GH_TOKEN@github.com/yildiz-online/retro-player.git

FROM moussavdb/build-java:23 as build
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
ARG nexus_retro_password
WORKDIR /app
COPY --from=clone /app/retro-player /app
RUN mvn package -s settings.xml -Pbuild-assembly -Pjavafx -DskipTests

FROM moussavdb/runtime-java:23
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
EXPOSE 8989
WORKDIR /app
COPY server /app
COPY --from=build /app/target/player-assembly.jar /app
CMD ["java", "-jar", "player-assembly.jar"]
