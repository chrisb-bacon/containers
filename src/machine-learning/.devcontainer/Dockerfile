FROM ubuntu:22.04
LABEL org.opencontainers.image.source="https://github.com/chrisb-bacon/containers"

WORKDIR /root/

ENV TZ=America/Chicago \
    DEBIAN_FRONTEND=noninteractive

# Add libcuda dummy dependency
RUN LAMBDA_REPO=$(mktemp) && \
    wget -O${LAMBDA_REPO} https://lambdalabs.com/static/misc/lambda-stack-repo.deb && \
    dpkg -i ${LAMBDA_REPO} && rm -f ${LAMBDA_REPO} && \
    apt update && sudo apt-get install -y lambda-stack-NVIDIA_REQUIRE_CUDA \
    reboot

ADD control .
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes equivs && \
    equivs-build control && \
    dpkg -i libcuda1-dummy_11.8_all.deb && \
    rm control libcuda1-dummy_11.8* && \
    apt-get remove --yes --purge --autoremove equivs && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /opt/conda/bin:$PATH

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
    espeak-ng \
    bzip2 \
    nvidia-container-toolkit \
    lambda-stack-cuda

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -y | sh

ADD lambda.gpg .
RUN apt-get update && \
    apt-get install --yes gnupg && \
    gpg --dearmor -o /etc/apt/trusted.gpg.d/lambda.gpg < lambda.gpg && \
    rm lambda.gpg && \
    echo "deb http://archive.lambdalabs.com/ubuntu jammy main" > /etc/apt/sources.list.d/lambda.list && \
    echo "Package: *" > /etc/apt/preferences.d/lambda && \
    echo "Pin: origin archive.lambdalabs.com" >> /etc/apt/preferences.d/lambda && \
    echo "Pin-Priority: 1001" >> /etc/apt/preferences.d/lambda && \
    echo "cudnn cudnn/license_preseed select ACCEPT" | debconf-set-selections && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install \
    --yes \
    --no-install-recommends \
    --option "Acquire::http::No-Cache=true" \
    --option "Acquire::http::Pipeline-Depth=0" \
    lambda-stack-cuda \
    lambda-server && \
    rm -rf /var/lib/apt/lists/*

# Setup for nvidia-docker
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=12.2"

ARG vscode
RUN if [[ -z "$devcontainercli" ]] ; then printf "\nERROR: This Dockerfile needs to be built with VS Code !" && exit 1; else printf "VS Code is detected: $devcontainercli"; fi