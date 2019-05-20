FROM debian:sid-slim
LABEL maintainer "Jessie Frazelle <jess@linux.com>"

RUN apt-get update && apt-get install -y \
	dirmngr \
	gnupg \
	--no-install-recommends \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0AB215679C571D1C8325275B9BDB3D89CE49EC21 \
	&& echo "deb http://ppa.launchpad.net/mozillateam/firefox-next/ubuntu xenial main" >> /etc/apt/sources.list.d/firefox.list \
	&& apt-get update && apt-get install -y \
	ca-certificates \
	ffmpeg \
	firefox \
	hicolor-icon-theme \
	libasound2 \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpulse0 \
	fonts-noto \
	fonts-noto-cjk \
	fonts-noto-color-emoji \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    apulse \
    alsa-utils \
    pulseaudio \
    vim \
    wget \
    unzip \
    sed \
	--no-install-recommends

ENV LANG en-US

COPY config/local.conf /etc/fonts/local.conf
COPY config/firefox_addons.sh /tmp

RUN echo 'pref("browser.tabs.remote.autostart", false);' >> /etc/firefox/syspref.js && \
    export LC_ALL="C" && \
    /tmp/firefox_addons.sh && \
    apt-get --purge autoremove \
    wget \
    vim \
    unzip \
    sed && \
    rm -rf /var/lib/apt/lists/*


WORKDIR /tmp

