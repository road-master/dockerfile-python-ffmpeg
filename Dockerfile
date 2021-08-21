FROM jrottenberg/ffmpeg:4.4-ubuntu2004 as production
# see: https://linuxize.com/post/how-to-install-python-3-9-on-ubuntu-20-04/
RUN apt-get update && apt-get install -y \
    software-properties-common \
 && rm -rf /var/lib/apt/lists/* \
 && add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y \
    python3.9 \
    python3-pip \
 && rm -rf /var/lib/apt/lists/*
 # Switch default Python3 to Python 3.9
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1

# For compatibility with Visual Studio Code
WORKDIR /workspace
