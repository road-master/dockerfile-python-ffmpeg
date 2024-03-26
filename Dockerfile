FROM jrottenberg/ffmpeg:6.0.1-ubuntu2204
ENV PYTHON_VERSION=3.12.2
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
 wget=1.20.3-1ubuntu2 \
# To build Python
 build-essential=12.8ubuntu1.1 \
# To prevent following error when build Python:
#   Traceback (most recent call last):
#   File "<frozen zipimport>", line 520, in _get_decompress_func
#   ModuleNotFoundError: No module named 'zlib'
# - Answer: pyenv install: 3.x BUILD FAILED (Ubuntu 20.04 using python-build 20180424) - Stack Overflow
#   https://stackoverflow.com/a/67853440/12721873
 zlib1g-dev=1:1.2.11.dfsg-2ubuntu1.5 \
# To enable Python SSL module
# - Answer: pip is configured with locations that require TLS/SSL, however the ssl module in Python is not available - Stack Overflow
#   https://stackoverflow.com/a/49696062/12721873
 libssl-dev=1.1.1f-1ubuntu2.22 \
 libncurses5-dev=6.2-0ubuntu2.1 \
 libsqlite3-dev=3.31.1-4ubuntu0.6 \
 libreadline-dev=8.0-4 \
 libtk8.6=8.6.10-1 \
 libgdm-dev=3.36.3-0ubuntu0.20.04.4 \
 libdb4o-cil-dev=8.0.184.15484+dfsg2-3 \
 libpcap-dev=1.9.1-3 \
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
