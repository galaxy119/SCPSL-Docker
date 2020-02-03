FROM ubuntu:16.04
MAINTAINER joker119
USER root
RUN echo "Building.."
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt-get update
RUN apt-get install apt-transport-https ca-certificates software-properties-common wget curl -y
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-xenial main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get update
RUN apt-get install -y mono-complete

RUN add-apt-repository multiverse
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install lib32gcc1 -y

RUN adduser --home /home/container container --disabled-password --gecos ""
RUN chown -R container:container /home/container
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

RUN curl -o steamcmd.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz
RUN tar -xzvf steamcmd.tar.gz

RUN ./steamcmd.sh +login anonymous +force_install_dir /home/container/scp_server +app_update 996560 +quit

WORKDIR /home/container/scp_server

RUN wget https://github.com/Grover-c13/MultiAdmin/releases/download/3.2.5/MultiAdmin.exe

COPY ./entrypoint.sh /entrypoint.sh

CMD["/bin/bash", "/entrypoint.sh"]
