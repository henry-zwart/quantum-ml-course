FROM ubuntu:20.02

# Copy over necessary files


# Set env vars
ENV LANG en_NZ.UTF-8
ENV LANGUAGE en_NZ:en
ENV HOME /home/coprosmo
ENV PYTHON_VERSION 3.10

# developer.nvidia.com sources are acting funny - workaround
RUN rm -rf /etc/apt/sources.list.d/nvidia-ml.list \
    && apt-get clean \
    && apt update

# Set timezone to Auckland
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y locales tzdata git \
    && locale-gen en_NZ.UTF-8 \
    && dpkg-reconfigure locales \
    && echo "Pacific/Auckland" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata


# Create user to create a home directory
RUN useradd coprosmo \
    && mkdir -p /code \
    && ln -s /code /home/coprosmo \
    && chown -R coprosmo:coprosmo /code


# Install apt packages
RUN apt update \
    && apt install -y --no-install-recommends awscli curl software-properties-common ffmpeg libsm6 libxext6 \
    && add-apt-repository ppa:deadsnakes/ppa

# Install python + packages
COPY requirements.txt /root/requirements.txt
RUN apt update \
    && apt install -y --no-install-recommends python${PYTHON_VERSION}-dev python${PYTHON_VERSION}-distutils \
    && curl -sS https://bootstrap.pypa.io/get-pip.py | python${PYTHON_VERSION} \
    && python${PYTHON_VERSION} -m pip install --upgrade setuptools pip \
    && python${PYTHON_VERSION} -m pip install --ignore-installed PyYAML \
    && python${PYTHON_VERSION} -m pip install -r /root/requirements.txt
