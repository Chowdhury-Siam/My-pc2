# Use the latest version of Ubuntu as the base image
FROM ubuntu:latest

# Install necessary packages for a remote desktop environment
RUN apt-get update && apt-get install -y \
    xfce4 \
    xrdp

# Set default command to start the xrdp service
CMD service xrdp start && sleep infinity
