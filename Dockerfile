FROM ubuntu:latest

RUN apt-get update && apt-get install -y xrdp xfce4 xfce4-terminal

EXPOSE 3389
CMD ["/bin/sh", "start.sh"]
