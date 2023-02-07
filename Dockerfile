# Use the latest Ubuntu image as the base image
FROM ubuntu:latest


# Create the 'dev' user with no password
RUN useradd -m -d /home/dev -s /bin/bash -p "" dev

# Give 'dev' user sudo privileges
RUN usermod -aG sudo dev

# Install some basic libraries used by the dependency installation scripts
RUN apt-get update && \
    apt-get install -y \
        jq \
        curl \
        sudo \
        git \
        npm \
        dpkg \
        software-properties-common \ 
        java-common

# Set Home/Work directory
WORKDIR /home/dev

# Copy the JSON formatted configuration file to the container
COPY dependencies.json dependencies.json

# Copy the shell scripts for installing dependencies to the container
COPY install_deps.sh install_deps.sh

# Run the main shell script for installing dependencies
RUN ./install_deps.sh

# Set "dev" as the default user
USER dev

# Start the container and run it in the background
CMD [ "tail", "-f", "/dev/null" ]
