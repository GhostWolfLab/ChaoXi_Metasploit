From kalilinux/kali-rolling:latest

WORKDIR  /root/

ENV LC_ALL C.UTF-8
ENV STAGING_KEY=RANDOM
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    tini \
    apache2 \
    metasploit-framework && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

RUN cd /opt && \
    wget https://github.com/tsl0922/ttyd/releases/latest/download/ttyd.x86_64 && \
    chmod 755 /opt/ttyd.x86_64 && \
    ln -s /opt/ttyd.x86_64 /usr/bin/ttyd

RUN echo "ServerName 127.0.0.1:80" >> /etc/apache2/apache2.conf && \

RUN cd /opt && \
    wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz && \
    tar -zxvf ngrok-v3-stable-linux-amd64.tgz && \
    rm -rf ngrok-v3-stable-linux-amd64.tgz    

WORKDIR /opt/

CMD ["msfconsole"]
