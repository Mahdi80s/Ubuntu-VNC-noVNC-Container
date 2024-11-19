FROM ubuntu:latest

LABEL maintainer="mahdisardari80@outlook.com"

WORKDIR /root

RUN sed -i 's/http:\/\/[a-zA-Z0-9]*\.[a-zA-Z0-9]*.*\.com/http:\/\/ir.ubuntu.sindad.cloud/g' /etc/apt/sources.list.d/ubuntu.sources && \
    apt update && \
    apt install -y \
        iputils-ping \
        iproute2 \
        net-tools \
        vim \
        expect \
        tigervnc-standalone-server && \ 
    #Install noVNC which is a VNC Client tool to connect to VNC server via Web Browser.    
    apt install novnc python3-websockify python3-numpy -y && \    
    apt install xubuntu-desktop task-xfce-desktop -y && \
    apt install -y wine64 && \
    dpkg --add-architecture i386 && \
    apt update && \
    apt install -y wine32:i386 && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash -c "Mahdi Sardari" Mahdi && \
    echo "Mahdi:1234" | chpasswd && \
    usermod -aG root Mahdi && \
    usermod -aG sudo Mahdi

COPY . .

RUN chmod +x entrypoint.exp && \
    chmod +x entrypoint-2.exp && \
    chmod +x up-container.sh && \
    mv /root/entrypoint.exp /home/Mahdi && \
    mv /root/entrypoint-2.exp /home/Mahdi && \
    mv /root/up-container.sh /home/Mahdi && \
    mv /root/idman642build23.exe /home/Mahdi

USER Mahdi

WORKDIR /home/Mahdi

RUN wine winecfg

EXPOSE 5901 5902 5903 5904 6080

ENTRYPOINT ["/home/Mahdi/up-container.sh"]