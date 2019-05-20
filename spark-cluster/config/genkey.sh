ssh-keygen -b 2048 -t rsa -f ${PWD}/config/id_rsa -q -N '' -y
chmod 0600 ${PWD}/config/id_rsa*
