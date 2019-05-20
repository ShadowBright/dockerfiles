image_name="$1"

if [ ! "$(docker ps -q -f name=${image_name})" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=${image_name})" ]; then
        # cleanup
		docker rm ${image_name}
    fi
    # run your container
    echo "running container ${image_name} "

    xhost local:root

	docker run  -d \
        --privileged \
        --rm \
		--memory 2gb \
		--net host \
		--cpuset-cpus 0 \
		-v /etc/localtime:/etc/localtime:ro \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v "${HOME}/.firefox/cache:/root/.cache/mozilla" \
		-v "${HOME}/.firefox/mozilla:/root/.mozilla" \
		-v "${HOME}/Downloads:/root/Downloads" \
		-v "${HOME}/Pictures:/root/Pictures" \
		-v "${HOME}/Torrents:/root/Torrents" \
        -v /run/dbus/:/run/dbus/ \
        -v /dev/shm:/dev/shm \
		-e "DISPLAY=unix${DISPLAY}" \
		-e GDK_SCALE \
		-e GDK_DPI_SCALE \
        --device /dev/snd \
		--device /dev/dri \
        -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
        -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native \
        -v ~/.config/pulse/cookie:/root/.config/pulse/cookie \
        --group-add $(getent group audio | cut -d: -f3) \
        --name ${image_name} \
		${image_name} firefox

fi
