#Download base image ubuntu 20.04
FROM ubuntu:18.04

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu
RUN apt update && apt upgrade -y

RUN apt install -y pwgen wget

RUN adduser --disabled-password --gecos '' nrgstaker

COPY ./keystore /home/nrgstaker/.energicore3/keystore/UTC--2021-05-02T12-51-02.131Z--94995fe33c263b71d21c03455457c3086cd83297
COPY ./setup.sh /home/nrgstaker/setup.sh

RUN apt install -y vim
