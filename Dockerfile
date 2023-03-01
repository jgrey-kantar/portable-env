# Use the latest Ubuntu image as the base image
FROM ubuntu:latest

ENV USERNAME="dev"
ENV DEBIAN_FRONTEND=noninteractive

# Install some basic libraries (required for automated container creation)
# 
# ** Keep this list to a minimum: additional libraries will be installed after
#    container creation as defined in dependencies.yml
RUN apt-get update && \
    apt-get install -y \
        jq \
        wget \
        curl \
        llvm \
        sudo \
        git \
        npm \
        dpkg \
        software-properties-common \ 
        java-common \
        build-essential \
        openssh-server \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        libncurses5-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libffi-dev \
        liblzma-dev



# # Create a new User to mimic the local user (no password)
# RUN useradd -m -d /home/${USERNAME} -s /bin/bash -p "" ${USERNAME}

# # Give new user sudo privileges inside the container
# RUN usermod -aG sudo ${USERNAME}

RUN mkdir "/run/sshd"

RUN useradd -ms /bin/bash dev && echo 'dev:dev' | chpasswd && adduser dev sudo

RUN ssh-keygen -A

# Remove archived repositories for Amazon Corretto (Use latest)
RUN grep -rl "apt.corretto.aws" /etc/apt/sources.list.d/ | xargs rm -f

# Adding Amazon Corretto (Java) Public Repository Key
RUN curl -sSL https://apt.corretto.aws/corretto.key | gpg --dearmor > /usr/share/keyrings/corretto-archive-keyring.gpg
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/corretto-archive-keyring.gpg] https://apt.corretto.aws/ stable main" > /etc/apt/sources.list.d/corretto.list


# # Add the Corretto repository to apt-get
RUN add-apt-repository "deb https://apt.corretto.aws stable main"

# Copy the setup configuration file to the container
COPY dependencies.json dependencies.json

# Copy the shell setup scripts to the container
COPY install_deps.sh install_deps.sh

# Run the setup scripts
RUN ./install_deps.sh

# Expose the ports used for Intellij Remote Development
# EXPOSE 5005
EXPOSE 22
# EXPOSE 63342

# Set the created user as the default user for the container
# USER ${USERNAME}
# # Set the Home/Work directory
# WORKDIR /home/${USERNAME}

# Start the container and run it in the background
CMD ["/usr/sbin/sshd", "-D"]
