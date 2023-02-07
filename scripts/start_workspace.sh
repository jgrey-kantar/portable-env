#!/bin/sh

exec docker run -it --rm \
    -v /home/jason/docker/portableDev:/workspace \
    -e HOST_USER_ID=$(id -u $USER) \
    -e HOST_GROUP_ID=$(id -g $USER) \
    -e GIT_USER_NAME=$GIT_USER_NAME \
    -e GIT_USER_EMAIL=$GIT_USER_EMAIL \
    -v ~/.ssh:/home/jason/.ssh \
    ls12styler/ide:latest