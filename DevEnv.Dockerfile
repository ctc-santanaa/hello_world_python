FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "Updating package manager and add basic commands" \
    && apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog \
    && apt-get -y install iproute2 procps lsb-release wget curl git

RUN echo "Adding a default locale that will work with interactive applications" \
    && apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN echo "Getting miniconda" \
    && wget --no-check-certificate --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh

RUN echo "Installing miniconda" \
    && bash miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

ENV PATH /opt/conda/bin:$PATH

RUN echo "Disable ssl_verify for Conda" \
    && conda config --set ssl_verify False \
    && conda install --name base pylint --yes

COPY requirements.txt .

RUN echo "Install python packages" \
   && pip install -r requirements.txt

RUN echo "Helpful for interactive container shells" \
    && echo "set -o vi" >> ~/.bashrc \
    && echo "export EDITOR=vi" >> ~/.bashrc

RUN echo "Avoid filemode issues with devcontainers" \
    && git config --global core.filemode false

ENV DEBIAN_FRONTEND=dialog