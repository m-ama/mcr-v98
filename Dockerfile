# Downloads and installs MATLAB Compiler Runtime v9.7 (2019b)
#
# Allows running MATLAB-compiled standalone files. Adapted from
# vistalab's MCR Dockerfile

FROM debian:buster-slim

# Install MCR dependencies
RUN apt-get update && apt-get -qq install -y \
    --no-install-recommends \
    unzip \
    xorg \
    wget \
    curl \
    ca-certificates

# Install MCR
RUN mkdir /mcr-install && \
    mkdir -p /opt/mcr/v98

RUN cd /mcr-install && \
    wget --no-check-certificate http://ssd.mathworks.com/supportfiles/downloads/R2020a/Release/0/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2020a_glnxa64.zip
RUN cd mcr-install && unzip MATLAB_Runtime_R2019b_Update_5_glnxa64.zip && \
    ./install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent
RUN rm -rf /mcr-install

# Configure environment variables for MCR
ENV LD_LIBRARY_PATH //opt/mcr/v98/runtime/glnxa64:/opt/mcr/v98/bin/glnxa64:/opt/mcr/v98/sys/os/glnxa64:/opt/mcr/v98/extern/bin/glnxa64
ENV XAPPLRESDIR /opt/mcr/v98/X11/app-defaults
