FROM leopays/leopays-builder:ubuntu-18.04-v0.1.0 as builder

ARG repo=https://github.com/leopays-core/leopays.git
ARG branch=master
ARG symbol=LPC

RUN git clone -b $branch $repo /leopays

WORKDIR /leopays

RUN git submodule update --init --recursive

RUN echo "$branch:$(git rev-parse HEAD)" > /etc/leopays-version

RUN ./scripts/leopays_build.sh -i /opt/leopays -m -y 

RUN ./scripts/leopays_install.sh

RUN ls /leopays/build/bin

RUN cd /leopays/build/packages && chmod 755 ./*.sh && ./generate_package.sh deb
