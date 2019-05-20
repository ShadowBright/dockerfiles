#!/bin/bash

USER_NAME="dev"
USER_GROUP="dev"

if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then

    userdel -f ${USER_NAME}

    if getent group ${GROUP_NAME} ; then
          groupdel ${GROUP_NAME}
    fi

    groupadd -g ${GROUP_ID} ${GROUP_NAME}
    useradd -l -u ${USER_ID} -g ${GROUP_NAME} ${USER_NAME}

    install -d -m 0755 -o ${USER_NAME} -g ${GROUP_NAME} /home/${USER_NAME}

    chown --changes --silent --no-dereference --recursive \
          ${USER_ID}:${GROUP_ID} \
        /home/${USER_NAME} \
        /data
fi
