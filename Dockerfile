FROM  ubuntu:jammy
MAINTAINER XTEND TECH
LABEL	description="Nimble Streamer on Ubuntu 22.04 LTS"

ENV	TZ=Europe/London
RUN	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

LABEL descrtiption="nimble streamer docker"
RUN apt-get update -y
RUN apt-get install wget -y

RUN wget -q -O - http://nimblestreamer.com/gpg.key |  tee /etc/apt/trusted.gpg.d/nimble.asc
RUN echo "deb http://nimblestreamer.com/ubuntu jammy/" >> /etc/apt/sources.list.d/nimble.list
RUN  apt-get update -y
RUN apt-get install bash coreutils  sudo  nimble -y

#ARG     WMSPANEL_SERVER_NAME=SRT-MACOS
#ARG     WMSPANEL_ACCOUNT=
#ARG     WMSPANEL_PASS=
# RUN echo "management_listen_interfaces = *" >> /etc/nimble/nimble.conf
ADD nimble /etc/nimble
ADD init.d /etc/init.d
#RUN	sudo /usr/bin/nimble_regutil -u $WMSPANEL_ACCOUNT -p $WMSPANEL_PASS --server-name $WMSPANEL_SERVER_NAME --host nimble.wmspanel.com
ENTRYPOINT      ["/usr/bin/nimble", "--conf-dir=/etc/nimble", "--log-dir=/var/log/nimble","--pidfile=/var/run/nimble/pid>
EXPOSE 8081 1935 
# 554 4444/udp
