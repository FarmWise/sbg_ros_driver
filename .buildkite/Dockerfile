FROM ubuntu

RUN apt-get update && apt-get install -y make debmake debhelper dkms quilt

RUN echo $FOO

FROM farmwise/build_essentials:latest

# Install kernel sources for host...
RUN apt-get update && apt-get install -y linux-headers-$(uname -r) && sudo apt-get install ros-kinetic-diagnostic-updater-farmwise

RUN mkdir -p /app/source

RUN chmod 777 /app && chmod 777 /app/source

# Host user mapping
RUN groupadd --system --gid 3434 buildkite-agent
RUN useradd --system --gid buildkite-agent --uid 3434 --shell /bin/bash --home-dir /app/source --create-home buildkite-agent
RUN chown -R buildkite-agent /app && chown -R buildkite-agent /app/source

USER buildkite-agent
WORKDIR /app/source
