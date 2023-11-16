FROM nvidia/cuda:12.2.0-base-ubuntu22.04 as base
LABEL org.opencontainers.image.source="https://github.com/chrisb-bacon/containers"

WORKDIR /root/

ENV TZ=America/Chicago \
    DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y --no-install-recommends \
    gcc \
    make \
    pkg-config \
    apt-transport-https \
    build-essential \
    software-properties-common \
    curl \
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
    awscli \
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

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -y | sh

RUN wget -nv -O- https://lambdalabs.com/install-lambda-stack.sh | I_AGREE_TO_THE_CUDNN_LICENSE=1 sh - && \
    reboot

ARG vscode
RUN if [[ -z "$devcontainercli" ]] ; then \
    printf "\nERROR: This Dockerfile needs to be built with VS Code !" && exit 1; \
    else printf "VS Code is detected: $devcontainercli"; fi