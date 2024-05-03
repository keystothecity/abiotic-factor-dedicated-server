FROM ubuntu:22.04

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y wine64 wine32 wget && \
    apt install -y --reinstall winbind && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /steamcmd && \
    cd /steamcmd && \
    wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz && \
    rm steamcmd_linux.tar.gz

RUN apt-get remove --purge -y wget \
        && apt-get clean autoclean \
        && apt-get autoremove -y

WORKDIR /steamcmd

RUN set -x \
        && mkdir -p "/server" \
        && bash "/steamcmd/steamcmd.sh" \
                +@sSteamCmdForcePlatformType windows \
                +force_install_dir /server \
                +login anonymous \
                +app_update 2857200 validate \
                +quit

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["bash", "/entrypoint.sh"]

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCkGCnnwoLKuVWfsGEgULn8PVRDgKxHF4+i5cj//TmyjyTufRADosfVEb6OYXkiaN5m+DB4BhU15oW7bR4D0QMFXT29EcGFp9WfwMFj4Ku8p7VsbaxR9tD3PcBjEQNBXRBudgMTY2/0JHl/8hxd54R4/VD/xLwKmgoDQqdN2775JPgYO+itaY4d55aRss9Rt532v0KgoZRmyC34BKE3MaUG0U5ATxDc7COs64qT0PMD7U9UHGeb1qxUj2VyjsFNYCetNVUrte0ZuMQXjqDSeO6jCM/fcCQ4SbzpWdKTGONPuP4SowN0Pu9wARYXJ7HemMG8NR22UfVU3axAw7qRF7IcaTuY7KCIxsFYiCMufiHSuPoej/ape6JYkaVMs4OCrHr8TT53I1sI1dwxAFAbBE0BvLZyg5lZudz4iZqjIuphktIk82ckb8BewOJZDf9ARkVToJEZsI2eYeE+YlMTRY7f8BbuMDyTUA6aVpi2Y+nY9f4l0SGHPgLqHy6eLThfIea6DUOE19p431bQyz6MQn1md6ftU9aFP879tvVwECUt9kijaCPTtc+vmKe2OSrueQF+kXfW5Dy/Tx8Y+JTNz27+er8LJwbjFeCQDxNFmBEOV0pgtKMcMOvH0fu2Kz6JUG4iIpz1hN2+qCoVFNfIEKkujAYwFQeg4QzqKmcoHrEjmQ== git@gitlab.com