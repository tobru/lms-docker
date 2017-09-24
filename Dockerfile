FROM ubuntu:trusty

ENV SQUEEZE_VOL=/srv/squeezebox \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \ 
    LC_ALL=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive \
    MEDIASERVER_URL=http://downloads.slimdevices.com/nightly/7.9/sc/d424bbe/logitechmediaserver_7.9.1~1505480690_amd64.deb

RUN locale-gen en_US.UTF-8

RUN locale-gen en_US.UTF-8 &&  apt-get update && \
	apt-get -y --force-yes install curl wget faad flac lame sox libio-socket-ssl-perl && \
	curl -Lsf -o /tmp/logitechmediaserver.deb $MEDIASERVER_URL && \
	dpkg -i /tmp/logitechmediaserver.deb && \
	rm -f /tmp/logitechmediaserver.deb && \
	apt-get clean

VOLUME $SQUEEZE_VOL
EXPOSE 3483 3483/udp 9000 9005 9090 32955

COPY entrypoint.sh /entrypoint.sh
COPY start-squeezebox.sh /start-squeezebox.sh
RUN chmod 755 /entrypoint.sh /start-squeezebox.sh

USER squeezeboxserver
ENTRYPOINT ["/entrypoint.sh"]

