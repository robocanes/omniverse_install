# Copyright (c) 2022, NVIDIA CORPORATION.  All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Reference:
# https://gitlab.com/nvidia/container-images/vulkan/-/blob/master/docker/Dockerfile.ubuntu
# https://github.com/NVIDIA-Omniverse/IsaacSim-dockerfiles
#
# Build the image:
# docker login nvcr.io
# docker build --pull -t \
#   isaac-sim:2023.1.0-ubuntu20.04 \
#   --build-arg ISAACSIM_VERSION=2023.1.0 \
#   --build-arg BASE_DIST=ubuntu20.04 \
#   --build-arg CUDA_VERSION=11.4.2 \
#   --build-arg VULKAN_SDK_VERSION=1.3.224.1 \
#   --file Dockerfile.2023.1.0-ubuntu20.04 .
#
# Run container:
# docker run --name isaac-sim --entrypoint bash -it --gpus all -e "ACCEPT_EULA=Y" --rm --network=host \
#   -v ~/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache/Kit:rw \
#   -v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
#   -v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
#   -v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
#   -v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
#   -v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
#   -v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
#   -v ~/docker/isaac-sim/documents:/root/Documents:rw \
# 	isaac-sim:2023.1.0-ubuntu20.04 \
# 	./runheadless.native.sh
#
# More info:
# https://developer.nvidia.com/isaac-sim
#
ARG DEBIAN_FRONTEND=noninteractive
ARG BASE_DIST=ubuntu20.04
ARG CUDA_VERSION=11.4.2
ARG ISAACSIM_VERSION=2023.1.0

# https://catalog.ngc.nvidia.com/orgs/nvidia/containers/isaac-sim
FROM nvcr.io/nvidia/isaac-sim:${ISAACSIM_VERSION} AS isaac-sim

# https://catalog.ngc.nvidia.com/orgs/nvidia/containers/cudagl
FROM nvidia/cudagl:${CUDA_VERSION}-base-${BASE_DIST}

RUN apt-get update && apt-get install -y --no-install-recommends \
    libatomic1 \
    libegl1 \
    libglu1-mesa \
    libgomp1 \
    libsm6 \
    libxi6 \
    libxrandr2 \
    libxt6 \
    libfreetype-dev \
    libfontconfig1 \
    openssl \
    libssl1.1 \
    wget \
    vulkan-utils \
&& apt-get -y autoremove \
&& apt-get clean autoclean \
&& rm -rf /var/lib/apt/lists/*

ARG VULKAN_SDK_VERSION=1.3.224.1
# Download the Vulkan SDK and extract the headers, loaders, layers and binary utilities
RUN wget -q --show-progress \
    --progress=bar:force:noscroll \
    https://sdk.lunarg.com/sdk/download/${VULKAN_SDK_VERSION}/linux/vulkansdk-linux-x86_64-${VULKAN_SDK_VERSION}.tar.gz \
    -O /tmp/vulkansdk-linux-x86_64-${VULKAN_SDK_VERSION}.tar.gz \ 
    && echo "Installing Vulkan SDK ${VULKAN_SDK_VERSION}" \
    && mkdir -p /opt/vulkan \
    && tar -xf /tmp/vulkansdk-linux-x86_64-${VULKAN_SDK_VERSION}.tar.gz -C /opt/vulkan \
    && mkdir -p /usr/local/include/ && cp -ra /opt/vulkan/${VULKAN_SDK_VERSION}/x86_64/include/* /usr/local/include/ \
    && mkdir -p /usr/local/lib && cp -ra /opt/vulkan/${VULKAN_SDK_VERSION}/x86_64/lib/* /usr/local/lib/ \
    && cp -a /opt/vulkan/${VULKAN_SDK_VERSION}/x86_64/lib/libVkLayer_*.so /usr/local/lib \
    && mkdir -p /usr/local/share/vulkan/explicit_layer.d \
    && cp /opt/vulkan/${VULKAN_SDK_VERSION}/x86_64/etc/vulkan/explicit_layer.d/VkLayer_*.json /usr/local/share/vulkan/explicit_layer.d \
    && mkdir -p /usr/local/share/vulkan/registry \
    && cp -a /opt/vulkan/${VULKAN_SDK_VERSION}/x86_64/share/vulkan/registry/* /usr/local/share/vulkan/registry \
    && cp -a /opt/vulkan/${VULKAN_SDK_VERSION}/x86_64/bin/* /usr/local/bin \
    && ldconfig \
    && rm /tmp/vulkansdk-linux-x86_64-${VULKAN_SDK_VERSION}.tar.gz && rm -rf /opt/vulkan

# Setup the required capabilities for the container runtime    
ENV NVIDIA_VISIBLE_DEVICES=all NVIDIA_DRIVER_CAPABILITIES=all

# Open ports for live streaming
# EXPOSE 47995-48012/udp \
#        47995-48012/tcp \
#        49000-49007/udp \
#        49000-49007/tcp \
#        49100/tcp \
#        8011/tcp \
#        8012/tcp \
#        8211/tcp \
#        8899/tcp \
#        8891/tcp

# ENV OMNI_SERVER http://omniverse-content-production.s3-us-west-2.amazonaws.com/Assets/Isaac/2023.1.0
# ENV OMNI_SERVER omniverse://localhost/NVIDIA/Assets/Isaac/2023.1.0
# ENV OMNI_USER admin
# ENV OMNI_PASS admin
ENV MIN_DRIVER_VERSION 525.60.11

# Copy Isaac Sim files
COPY --from=isaac-sim /isaac-sim /isaac-sim
RUN mkdir -p /root/.nvidia-omniverse/config
COPY --from=isaac-sim /root/.nvidia-omniverse/config /root/.nvidia-omniverse/config
COPY --from=isaac-sim /etc/vulkan/icd.d/nvidia_icd.json /etc/vulkan/icd.d/nvidia_icd.json
COPY --from=isaac-sim /etc/vulkan/icd.d/nvidia_icd.json /etc/vulkan/implicit_layer.d/nvidia_layers.json

# WORKDIR /isaac-sim

# Add symlink
RUN ln -s exts/omni.isaac.examples/omni/isaac/examples extension_examples

# Default entrypoint to launch headless with streaming
# ENTRYPOINT /isaac-sim/runheadless.native.sh

# -------------------------------------------------------------------------------

# Chris Additional Stuff

# ARG WORK_DIR=/isaac-sim
ARG WORK_DIR=/root

WORKDIR ${WORK_DIR}

ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages and NVIDIA drivers
RUN apt-get -y update 
RUN apt-get -y upgrade
RUN apt-get -y autoremove
RUN apt-get -y install\
    ubuntu-drivers-common \
    software-properties-common \
    build-essential \
    python3 \
    python3-pip
RUN apt-get -y clean
RUN apt-get -y autoremove 
RUN rm -rf /var/lib/apt/lists/*

RUN ubuntu-drivers autoinstall

# Install packages
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y autoremove
RUN apt-get -y install \
    ffmpeg \
    iproute2 \
    terminator \
    sudo \
    iputils-ping \
    curl \
    wget \
    gpg \
    git \
    locales \
    tzdata \
    zsh \
    vim \
    eog \
    firefox \
    mesa-utils \
    mesa-utils-extra
RUN apt-get -y clean
RUN apt-get -y autoremove
RUN rm -rf /var/lib/apt/lists/*

# VS Code Install
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
RUN install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
RUN echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
RUN rm -f packages.microsoft.gpg
RUN apt-get -y install apt-transport-https
RUN apt-get -y update && apt-get -y upgrade && apt-get -y autoremove
RUN apt-get install code

# Set up the locale and timezone
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# ------------------------------------------------------------------------
# Install custom packages/software here

# ROS Software Setup

RUN apt-get -y update && apt-get -y upgrade && apt-get -y autoremove

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RUN apt-get -y update && apt-get -y upgrade && apt-get -y autoremove

RUN apt-get -y install \
    ros-noetic-desktop-full \
    ros-noetic-moveit \
    ros-noetic-panda-moveit-config \
    ros-noetic-franka-hw \
    libgflags-dev \
    ros-noetic-rviz-imu-plugin \
    ros-noetic-map-server \
    ros-noetic-dwa-local-planner \
    ros-noetic-move-base \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    ros-noetic-ros-numpy

RUN apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

RUN rosdep init
RUN rosdep update

# TMC Software Setup

# RUN apt-get -y update && apt-get -y upgrade && apt-get -y autoremove

# RUN sh -c 'echo "deb [arch=amd64] https://hsr-user:jD3k4G2e@packages.hsr.io/ros/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/tmc.list'
# RUN sh -c 'echo "deb [arch=amd64] https://hsr-user:jD3k4G2e@packages.hsr.io/tmc/ubuntu `lsb_release -cs` multiverse main" >> /etc/apt/sources.list.d/tmc.list'
# RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
# RUN wget https://hsr-user:jD3k4G2e@packages.hsr.io/tmc.key -O - | sudo apt-key add -
# RUN wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc -O - | sudo apt-key add -
# RUN wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
# RUN sh -c 'mkdir -p /etc/apt/auth.conf.d'
# RUN sh -c '/bin/echo -e "machine packages.hsr.io\nlogin hsr-user\npassword jD3k4G2e" >/etc/apt/auth.conf.d/auth.conf'
# RUN sh -c '/bin/echo -e "Package: ros-noetic-laser-ortho-projector\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-laser-scan-matcher\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-laser-scan-sparsifier\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-laser-scan-splitter\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-ncd-parser\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-polar-scan-matcher\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-scan-to-cloud-converter\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-scan-tools\nPin: version 0.3.3*\nPin-Priority: 1001" > /etc/apt/preferences'

# RUN apt-get -y update && apt-get -y upgrade && apt-get -y autoremove

# RUN apt-get install -y ros-noetic-tmc-desktop-full

# RUN apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Isaac Sim Dependencies
RUN ln -s /isaac-sim ${WORK_DIR}/isaac-sim
RUN ${WORK_DIR}/isaac-sim/python.sh -m pip install rospkg

# Nucleus Workstation Install
COPY nucleus/ws/nucleus-workstation-2023.2.3 /nucleus-ws

# ------------------------------------------------------------------------

ENV DISPLAY="${DISPLAY}"

# Set the timezone to avoid prompts
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Create a new user and set password
RUN useradd -m ubuntu
RUN echo "ubuntu:ubuntu" | chpasswd
RUN adduser ubuntu sudo

# ------------------------------------------------------------------------
# TMC ROS bashrc
COPY .bashrc /root/.bashrc
RUN chown root:root /root/.bashrc

COPY .bashrc /home/ubuntu/.bashrc
RUN chown ubuntu:ubuntu /home/ubuntu/.bashrc
# ------------------------------------------------------------------------

# Copy the startup script into the container
COPY scripts/code.sh ${WORK_DIR}
COPY scripts/firefox.sh ${WORK_DIR}

# Ensure the script is executable
RUN chmod +x ${WORK_DIR}/code.sh
RUN chmod +x ${WORK_DIR}/firefox.sh

# Chris Startup cmds
COPY scripts/entrypoint.sh ${WORK_DIR}
RUN chmod +x ${WORK_DIR}/entrypoint.sh


ENTRYPOINT /root/entrypoint.sh