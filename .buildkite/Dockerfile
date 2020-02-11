#FROM ubuntu
FROM nvidia/cuda:9.0-cudnn7-runtime

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y make cmake dkms quilt apt-utils debmake debhelper

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros1-latest.list

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y python-rosdep python-rosinstall python-vcstools

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# bootstrap rosdep
RUN rosdep init && rosdep update

# install ros packages
ENV ROS_DISTRO kinetic
RUN apt-get update && apt-get install -y ros-kinetic-ros-core=1.3.2-0* ros-kinetic-ros-base=1.3.2-0*
# RUN apt-get update && apt-get install -y ros-kinetic-ros-core ros-kinetic-ros-base
# RUN apt-get install -y catkin libroscpp-dev libroscpp-msgs-dev ros-roscpp-msgs

# Install kernel sources for host...
RUN apt-get update && apt-get install -y linux-headers-$(uname -r)

RUN mkdir -p /app/source

RUN chmod 777 /app && chmod 777 /app/source

# Host user mapping
RUN groupadd --system --gid 3434 buildkite-agent
RUN useradd --system --gid buildkite-agent --uid 3434 --shell /bin/bash --home-dir /app/source --create-home buildkite-agent
RUN chown -R buildkite-agent /app && chown -R buildkite-agent /app/source

USER buildkite-agent
WORKDIR /app/source
