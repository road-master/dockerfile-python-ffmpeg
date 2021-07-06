FROM python:3.9.6-slim-buster

# Avoid warnings by switching to noninteractive
# see: https://docs.docker.com/engine/faq/#why-is-debian_frontendnoninteractive-discouraged-in-dockerfiles
ENV DEBIAN_FRONTEND=noninteractive

# Configure apt and install packages
# 'deb-multimedia.org' is a site that offers a repository of multimedia packages
RUN echo "deb http://www.deb-multimedia.org buster main non-free" >> /etc/apt/sources.list \
    && apt-get update -oAcquire::AllowInsecureRepositories=true \
    && apt-get -y install deb-multimedia-keyring --allow-unauthenticated\
    && apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    && apt-get -y install ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=

# For compatibility with Visual Studio Code
WORKDIR /workspace
