FROM leopays/builder:ubuntu-18.04-v0.1.0 as builder

ARG repo=https://github.com/leopays-core/leopays.git
ARG branch=master
ARG symbol=LPC
ARG type=Release

WORKDIR /leopays

RUN git clone -b $branch $repo .
RUN  git submodule update --init --recursive && \
    echo "$branch:$(git rev-parse HEAD)" > /etc/leopays-version
RUN ./scripts/leopays_build.sh -y \
    # -P -b DIR -c -d \
    -o $type \
    -s $symbol \
    -i /opt/leopays \
    -m
RUN ./scripts/leopays_install.sh
RUN cp /leopays/docker/config.ini / && \
    ln -s /leopays/unittests/contracts /contracts && \
    cp /leopays/docker/leopays-node.sh /opt/leopays/bin/leopays-node.sh && \
    ln -s /leopays/tutorials /tutorials

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    openssl ca-certificates vim psmisc python3-pip && \
    rm -rf /var/lib/apt/lists/*
RUN pip3 install numpy
ENV LEOPAYS_ROOT=/opt/leopays
RUN chmod +x /opt/leopays/bin/leopays-node.sh
ENV LD_LIBRARY_PATH /usr/local/lib
ENV PATH $LEOPAYS_ROOT/bin:$PATH
