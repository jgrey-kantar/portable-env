#!/bin/sh

# Verify or set Environment Variables


# GIT Credentials
if [ -z "$GIT_USER_NAME" ]
then
    echo "\$GIT_USER_NAME is empty"
else
    echo "\$GIT_USER_NAME is=$GIT_USER_NAME"
fi

if [ -z "$GIT_USER_EMAIL" ]
then
    echo "\$GIT_USER_EMAIL is empty"
else
    echo "\$GIT_USER_EMAIL is=$GIT_USER_EMAIL"
fi