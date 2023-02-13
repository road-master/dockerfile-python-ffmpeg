FROM jrottenberg/ffmpeg:5.1.2-ubuntu2004
# see: https://linuxize.com/post/how-to-install-python-3-9-on-ubuntu-20-04/
RUN apt-get update && apt-get install -y \
    software-properties-common \
 && rm -rf /var/lib/apt/lists/* \
 && add-apt-repository ppa:deadsnakes/ppa
ENV PYTHON_VERSION=3.11
RUN apt-get update && apt-get install -y \
    python${PYTHON_VERSION} \
    # To prevent error when run pip because this package is not latest:
    # - Answer: python - ImportError: cannot import name 'html5lib' from 'pip._vendor'
    #   (/usr/lib/python3/dist-packages/pip/_vendor/__init__.py) - Stack Overflow
    #   https://stackoverflow.com/a/70431656
    # python3-pip \
    curl \
    # To prevent ModuleNotFoundError: No module named 'distutils.util' when run pip
    python${PYTHON_VERSION}-distutils \
 && rm -rf /var/lib/apt/lists/*
# Switch default Python3 to Python 3.x
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${PYTHON_VERSION} 1
# To prevent error when run pip:
# - Answer: python - ImportError: cannot import name 'html5lib' from 'pip._vendor'
#   (/usr/lib/python3/dist-packages/pip/_vendor/__init__.py) - Stack Overflow
#   https://stackoverflow.com/a/70431656
RUN curl https://bootstrap.pypa.io/get-pip.py | python3

# For compatibility with Visual Studio Code
WORKDIR /workspace
