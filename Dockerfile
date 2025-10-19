FROM ubuntu:22.04
LABEL org.opencontainers.image.source=https://github.com/skalldri/nrf-connect-sdk-docker
LABEL org.opencontainers.image.description="Docker image for compiling projects using the Nordic nRF Connect SDK v3.1.1"
RUN apt update && apt install -y gcc gcc-multilib g++-multilib build-essential wget ca-certificates qemu-system-arm git libxcb-render-util0 libxcb-shape0 libxcb-icccm4 libxcb-keysyms1 libxcb-image0 libxkbcommon-x11-0 libsm6 libice6 udev dialog usbutils locales && rm -rf /var/lib/apt/lists/*
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN wget https://files.nordicsemi.com/artifactory/swtools/external/nrfutil/executables/x86_64-unknown-linux-gnu/nrfutil -q -O /usr/local/bin/nrfutil && chmod +x /usr/local/bin/nrfutil && nrfutil install toolchain-manager=0.15.0 && nrfutil install sdk-manager=1.8.0 && nrfutil install device=2.15.1
RUN nrfutil toolchain-manager install --ncs-version v3.1.1
RUN nrfutil toolchain-manager env --as-script > /opt/toolchain-env.sh
RUN nrfutil sdk-manager install v3.1.1
COPY --chmod=0555 bash_env.sh /opt/bash_env.sh
ENV BASH_ENV=/opt/bash_env.sh
RUN cat /opt/bash_env.sh >> /root/.bashrc