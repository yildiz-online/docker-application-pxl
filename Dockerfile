FROM alpine/git:latest as clone
LABEL maintainer="Grégory Van den Borre <vandenborre.gregory@hotmail.fr>"
ARG GH_TOKEN
WORKDIR /app
RUN git clone -b develop https://$GH_TOKEN@github.com/yildiz-online/retro-player-server.git

FROM moussavdb/build-java:sts as build
LABEL maintainer="Grégory Van den Borre <vandenborre.gregory@hotmail.fr>"
ARG nexus_retro_password
WORKDIR /app
COPY --from=clone /app/retro-player-server /app
RUN mvn package -s settings.xml -Pbuild-assembly -DskipTests

FROM moussavdb/runtime-java:lts
LABEL maintainer="Grégory Van den Borre <vandenborre.gregory@hotmail.fr>"
EXPOSE 8989
WORKDIR /app
COPY --from=build /app/target/player-assembly.jar /app
CMD ["java", "-jar", "player-assembly.jar"]
