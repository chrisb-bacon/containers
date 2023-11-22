FROM nvidia/cuda:12.2.0-base-ubuntu22.04 as base
LABEL org.opencontainers.image.source="https://github.com/chrisb-bacon/containers"

ENV TZ=America/Chicago \
    DEBIAN_FRONTEND=noninteractive

ENV PATH $PATH

RUN apt update && \
    apt install -y --no-install-recommends \
    gcc \
    make \
    pkg-config \
    apt-transport-https \
    build-essential \
    software-properties-common \
    curl \
    python3-pip-whl \
    python3-pip \
    apt-utils \
    ca-certificates \
    wget \
    rsync \
    git \
    vim \
    mlocate \
    libssl-dev \
    openssh-client \
    unzip \
    unrar \
    zip \
    csvkit \
    emacs \
    joe \
    jq \
    dialog \
    man-db \
    manpages \
    manpages-dev \
    manpages-posix \
    manpages-posix-dev \
    nano \
    iputils-ping \
    sudo \
    ffmpeg \
    libsm6 \
    libxext6 \
    libboost-all-dev \
    gnupg \
    gnupg2 \
    gnupg1 \
    libffi-dev \
    bzip2

ENV SHELL=/bin/bash \
    DOCKER_BUILDKIT=1

# Remove scripts now that we're done with them
RUN apt-get clean -y && rm -rf /tmp/scripts

ARG vscode
RUN if [[ -z "$devcontainercli" ]] ; then \
    printf "\nERROR: This Dockerfile needs to be built with VS Code !" && exit 1; \
    else printf "VS Code is detected: $devcontainercli"; fi