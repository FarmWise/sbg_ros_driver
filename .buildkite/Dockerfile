FROM ros:noetic-ros-base-focal

RUN apt-get update && apt-get install -y make debmake debhelper dkms quilt

# Install kernel sources for host...
RUN apt-get update

RUN mkdir -p /app/source
RUN chmod 777 /app && chmod 777 /app/source

# Host user mapping
RUN groupadd --system --gid 3434 buildkite-agent
RUN useradd --system --gid buildkite-agent --uid 3434 --shell /bin/bash \
    --home-dir /app/source --create-home buildkite-agent
RUN chown -R buildkite-agent /app && chown -R buildkite-agent /app/source

# Add buildkite agent to passwordless sudo
RUN gpasswd --add buildkite-agent sudo
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER buildkite-agent
WORKDIR /app/source
