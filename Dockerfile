FROM jrottenberg/ffmpeg:5.1.2-ubuntu2004
ENV PYTHON_VERSION=3.11.2
# The apt-get stops and prompts following message:
#    => => # questions will narrow this down by presenting a list of cities, representing                                                                                                                                                                             
#    => => # the time zones in which they are located.                                                                                                                                                                                                                
#    => => #   1. Africa      4. Australia  7. Atlantic  10. Pacific  13. Etc                                                                                                                                                                                         
#    => => #   2. America     5. Arctic     8. Europe    11. SystemV                                                                                                                                                                                                  
#    => => #   3. Antarctica  6. Asia       9. Indian    12. US                                                                                                                                                                                                       
#    => => # Geographic area:
# - Answer: docker - When building from Dockerfile, Debian/Ubuntu package install debconf Noninteractive install not allowed - Server Fault
#   https://serverfault.com/a/797318/571473
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
# To download Python tar gz file
 wget \
# To build Python
 build-essential \
# To prevent following error when build Python:
#   Traceback (most recent call last):
#   File "<frozen zipimport>", line 520, in _get_decompress_func
#   ModuleNotFoundError: No module named 'zlib'
# - Answer: pyenv install: 3.x BUILD FAILED (Ubuntu 20.04 using python-build 20180424) - Stack Overflow
#   https://stackoverflow.com/a/67853440/12721873
 zlib1g-dev \
# To enable Python SSL module
# - Answer: pip is configured with locations that require TLS/SSL, however the ssl module in Python is not available - Stack Overflow
#   https://stackoverflow.com/a/49696062/12721873
 libssl-dev libncurses5-dev libsqlite3-dev libreadline-dev libtk8.6 libgdm-dev libdb4o-cil-dev libpcap-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /opt
RUN wget --progress=dot:giga https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
 && tar -xvf Python-${PYTHON_VERSION}.tgz
WORKDIR /opt/Python-${PYTHON_VERSION}
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
 && ./configure \
 && make \
 && make install
# For compatibility with Visual Studio Code
WORKDIR /workspace
